import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      ...corsHeaders,
      "Content-Type": "application/json",
    },
  });
}

function bufferToBase64(buffer: ArrayBuffer) {
  const bytes = new Uint8Array(buffer);
  let binary = "";
  for (let i = 0; i < bytes.byteLength; i += 1) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const RESEND_API_KEY = Deno.env.get("RESEND_API_KEY");
    const REPORT_TO_EMAIL = Deno.env.get("REPORT_TO_EMAIL");
    const REPORT_FROM_EMAIL = Deno.env.get("REPORT_FROM_EMAIL");
    const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
    const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!RESEND_API_KEY || !REPORT_TO_EMAIL || !REPORT_FROM_EMAIL || !SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      return jsonResponse({ error: "missing_env" }, 500);
    }

    const { reportPath, studentName, lastName, className } = await req.json();

    if (!reportPath) {
      return jsonResponse({ error: "missing_report_path" }, 400);
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false },
    });

    const { data: fileData, error: downloadError } = await supabase
      .storage
      .from("automatenlabor-reports")
      .download(reportPath);

    if (downloadError || !fileData) {
      return jsonResponse({ error: "download_failed", details: downloadError?.message || null }, 500);
    }

    const fileBuffer = await fileData.arrayBuffer();
    const base64Content = bufferToBase64(fileBuffer);
    const safeFirstName = String(studentName || "schueler").trim();
    const safeLastName = String(lastName || "").trim();
    const safeClass = String(className || "").trim();
    const displayName = [safeFirstName, safeLastName].filter(Boolean).join(" ").trim() || "Unbekannt";
    const fileName = reportPath.split("/").pop() || "automatenlabor-auswertung.pdf";

    const resendResponse = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${RESEND_API_KEY}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: REPORT_FROM_EMAIL,
        to: [REPORT_TO_EMAIL],
        subject: `Automatenlabor: ${displayName}${safeClass ? ` (${safeClass})` : ""}`,
        html: `
          <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; color: #1f2a37;">
            <h2 style="margin-bottom: 8px;">Neue Automatenlabor-Auswertung</h2>
            <p style="margin: 0 0 12px;">Eine Mission wurde beendet.</p>
            <ul style="padding-left: 18px; line-height: 1.6;">
              <li><strong>Vorname:</strong> ${safeFirstName || "-"}</li>
              <li><strong>Nachname:</strong> ${safeLastName || "-"}</li>
              <li><strong>Klasse:</strong> ${safeClass || "-"}</li>
            </ul>
            <p style="margin-top: 14px;">Die PDF-Auswertung ist als Anhang beigefügt.</p>
          </div>
        `,
        attachments: [
          {
            filename: fileName,
            content: base64Content,
          },
        ],
      }),
    });

    if (!resendResponse.ok) {
      const resendError = await resendResponse.text();
      return jsonResponse({ error: "mail_failed", details: resendError }, 500);
    }

    const resendData = await resendResponse.json();
    return jsonResponse({ ok: true, provider: "resend", id: resendData.id || null });
  } catch (error) {
    console.error(error);
    return jsonResponse({ error: "unexpected_error", details: String(error) }, 500);
  }
});

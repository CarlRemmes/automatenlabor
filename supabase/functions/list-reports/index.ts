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

function formatDate(value: string | null) {
  if (!value) return "";
  try {
    return new Intl.DateTimeFormat("de-DE", {
      dateStyle: "short",
      timeStyle: "short",
      timeZone: "Europe/Berlin",
    }).format(new Date(value));
  } catch {
    return value;
  }
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
    const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
      return jsonResponse({ error: "missing_env" }, 500);
    }

    const { input_pin } = await req.json();
    if (!input_pin) {
      return jsonResponse({ error: "missing_pin" }, 400);
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
      auth: { persistSession: false },
    });

    const { data: pinOk, error: pinError } = await supabase.rpc("verify_helper_pin", {
      input_pin,
    });

    if (pinError || !pinOk) {
      return jsonResponse({ error: "invalid_pin" }, 401);
    }

    const { data: rows, error: rowsError } = await supabase
      .from("worksheet_attempts")
      .select("student_name,last_name,class_name,submitted_at,report_path")
      .not("report_path", "is", null)
      .neq("report_path", "")
      .order("submitted_at", { ascending: false });

    if (rowsError) {
      return jsonResponse({ error: "load_failed", details: rowsError.message }, 500);
    }

    const reports = [];
    for (const row of rows || []) {
      const { data: signed, error: signedError } = await supabase
        .storage
        .from("automatenlabor-reports")
        .createSignedUrl(row.report_path, 60 * 30);

      reports.push({
        student_name: row.student_name,
        last_name: row.last_name,
        class_name: row.class_name,
        submitted_at: row.submitted_at,
        submitted_at_label: formatDate(row.submitted_at),
        report_path: row.report_path,
        signed_url: signedError ? "" : signed?.signedUrl || "",
      });
    }

    return jsonResponse({ reports });
  } catch (error) {
    console.error(error);
    return jsonResponse({ error: "unexpected_error", details: String(error) }, 500);
  }
});

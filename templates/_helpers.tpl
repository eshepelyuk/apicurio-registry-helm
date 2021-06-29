{{- define "apicurio-registry.name" -}}
{{ printf "%s-apicurio-registry" .Release.Name }}
{{- end -}}

{{- define "apicurio-registry-sync.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "apicurio-registry-sync.selectorLabels" . }}
{{- end }}

{{- define "apicurio-registry-sync.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "apicurio-registry.image" -}}
{{- $sfx := "" -}}
{{- if hasKey . "sql" -}}
{{- $sfx = "sql" -}}
{{- else if hasKey . "kafka" -}}
{{- $sfx = "kafkasql" -}}
{{- else -}}
{{- $sfx = "mem" -}}
{{- end -}}
{{ printf "%s/%s-%s:%s" .image.registry .image.repository $sfx .image.tag }}
{{- end -}}

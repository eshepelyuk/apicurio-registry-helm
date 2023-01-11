{{- define "apicurio-registry.name" -}}
{{ printf "%s-apicurio-registry" .Release.Name }}
{{- end -}}

{{- define "apicurio-registry.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "apicurio-registry.selectorLabels" . }}
{{- end }}

{{- define "apicurio-registry.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "apicurio-registry.image" -}}
{{- $sfx := .persistence -}}
{{- if eq .persistence "memory" -}}
{{- $sfx = "mem" -}}
{{- end -}}
{{ printf "%s/%s-%s:%s" .image.registry .image.repository $sfx .image.tag }}
{{- end -}}

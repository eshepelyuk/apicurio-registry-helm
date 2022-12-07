{{- define "apicurio-registry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "apicurio-registry.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "apicurio-registry.serviceAccountName" -}}
{{ default (include "apicurio-registry.fullname" .) .Values.serviceAccount.name }}
{{- end -}}

{{- define "apicurio-registry.serviceAccount" -}}
{{- if .Values.serviceAccount.create -}}
serviceAccountName: {{ include "apicurio-registry.serviceAccountName" . }}
{{- end -}}
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

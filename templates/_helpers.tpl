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

{{/* Allow KubeVersion to be overridden. */}}
{{- define "apicurio-registry.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Get Ingress API Version */}}
{{- define "apicurio-registry.ingress.apiVersion" -}}
  {{- if and (.Capabilities.APIVersions.Has "networking.k8s.io/v1") (semverCompare ">= 1.19-0" (include "apicurio-registry.kubeVersion" .)) -}}
      {{- print "networking.k8s.io/v1" -}}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "apicurio-registry.ingress.isStable" -}}
  {{- eq (include "apicurio-registry.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
{{- end -}}

{{/* Check Ingress supports pathType */}}
{{/* pathType was added to networking.k8s.io/v1beta1 in Kubernetes 1.18 */}}
{{- define "apicurio-registry.ingress.supportsPathType" -}}
  {{- or (eq (include "apicurio-registry.ingress.isStable" .) "true") (and (eq (include "apicurio-registry.ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18-0" (include "apicurio-registry.kubeVersion" .))) -}}
{{- end -}}



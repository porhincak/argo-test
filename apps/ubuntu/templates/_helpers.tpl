{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "busybox.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Web labels
*/}}
{{- define "busybox.labels" -}}
helm.sh/chart: {{ include "busybox.chart" . }}
{{ include "busybox.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Web selector labels
*/}}
{{- define "busybox.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Storage selector labels */}}
{{ define "busybox.storage.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Storage labels */}}
{{ define "busybox.storage.labels" -}}
helm.sh/chart: {{ include "busybox.chart" . }}
{{ include "busybox.storage.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "sizeToBytes" -}}
{{- $size := . -}}
    {{- if hasSuffix "Gi" $size -}}
      {{- mul (trimSuffix "Gi" $size | int) 1073741824 -}}
    {{- else if hasSuffix "G" $size -}}
      {{- mul (trimSuffix "G" $size | int) 1000000000 -}}
    {{- else if hasSuffix "Mi" $size -}}
      {{- mul (trimSuffix "Mi" $size | int) 1048576 -}}
    {{- else if hasSuffix "M" $size -}}
      {{- mul (trimSuffix "M" $size | int) 1000000 -}}
    {{- else if hasSuffix "Ti" $size -}}
      {{- mul (trimSuffix "Ti" $size | int) 1099511627776 -}}
    {{- else if hasSuffix "T" $size -}}
      {{- mul (trimSuffix "T" $size | int) 1000000000000 -}}
    {{- else -}}
      {{- $size | int -}}
    {{- end -}}
{{- end -}}
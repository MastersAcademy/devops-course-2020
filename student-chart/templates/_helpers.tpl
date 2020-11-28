{{- define "name" -}}
{{- default .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

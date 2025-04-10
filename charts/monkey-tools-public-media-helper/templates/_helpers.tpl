{{/*
Expand the name of the chart.
*/}}
{{- define "monkey-tools-public-media-helper.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monkey-tools-public-media-helper.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified server name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monkey-tools-public-media-helper.sandbox.fullname" -}}
{{ template "monkey-tools-public-media-helper.fullname" . }}
{{- end -}}

{{/*
Create a default fully qualified server name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "monkey-tools-public-media-helper.piston.fullname" -}}
{{ template "monkey-tools-public-media-helper.fullname" . }}-piston
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "monkey-tools-public-media-helper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "monkey-tools-public-media-helper.labels" -}}
helm.sh/chart: {{ include "monkey-tools-public-media-helper.chart" . }}
{{ include "monkey-tools-public-media-helper.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "monkey-tools-public-media-helper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monkey-tools-public-media-helper.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "monkey-tools-public-media-helper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "monkey-tools-public-media-helper.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* annotations defiend by user*/}}
{{- define "monkey-tools-public-media-helper.ud.annotations" -}}
{{- if .Values.annotations }}
{{- toYaml .Values.annotations }}
{{- end -}}
{{- end -}}

{{/* labels defiend by user*/}}
{{- define "monkey-tools-public-media-helper.ud.labels" -}}
{{- if .Values.labels }}
{{- toYaml .Values.labels }}
{{- end -}}
{{- end -}}
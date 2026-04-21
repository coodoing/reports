#!/bin/bash
# Duplicate files with underscores to maintain backward compatibility

cd _site/reports

# ML sys reports
cp mlsys2026-analysis.html mlsys2026_analysis.html
cp agent-engineering-report.html agent_engineering_report.html
cp ai-weekly-2026-04-19.html ai_weekly_2026-04-19.html
cp intel-research-report-2026.html intel_research_report_2026.html
cp aacr-2026-report.html aacr2026_report.html

echo "Created backward compatible URLs"
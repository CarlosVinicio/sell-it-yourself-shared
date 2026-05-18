{
  "agent": {
    "name": "Agente Inmobiliario SINAGENCIAS.ES",
    "version": "1.2",
    "language": "es"
  },
  "permissions": {
    "read": [
      "docs/**",
      "research/**"
    ],
    "write": [
      "docs/business/**",
      "docs/product/**",
      "docs/marketing/**",
      "docs/data/**",
      "docs/memory/**",
      "research/**"
    ],
    "readonly": [
      "docs/legal/**",
      "docs/tech/**",
      "docs/ux/**"
    ],
    "never_modify": [
      ".claude/CLAUDE.md",
      ".claude/settings.json"
    ]
  },
  "behavior": {
    "always_read_on_start": [
      "docs/memory/context.md",
      "docs/memory/decisions.md",
      "docs/memory/pending.md"
    ],
    "update_on_end": [
      "docs/memory/context.md",
      "docs/memory/pending.md"
    ],
    "routing_required": true,
    "legal_warnings": true,
    "adr_on_tech_decision": true
  },
  "conventions": {
    "date_format": "YYYY-MM-DD",
    "language": "es-ES",
    "output_format": "markdown",
    "file_naming": "kebab-case"
  },
  "phases": {
    "current": "Tier 1 — construcción",
    "total": 10,
    "completed": [1, 2, 3, 4, "5-tier1", "6-tier1", "7-tier1", "8-tier1", "9-tier1"],
    "in_progress": [],
    "blocked": []
  }
}

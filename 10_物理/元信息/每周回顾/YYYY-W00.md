---
week: <% tp.date.now("YYYY-[W]WW") %>
---

# WEEK <% tp.date.now("[W]WW") %> - Physics

---

## Summary

- Problems solved: ___
- Diagrams drawn: ___

---

## Diagrams This Week

| Type | Count |
|------|-------|
| Scene | ___ |
| FBD | ___ |
| Field | ___ |
| Loop | ___ |

---

## This Week's Mistakes

```dataview
table course, error_type, diagram_type, created
from "physics"
where type = "mistake" and created > date(today) - dur(7 days)
sort created desc
```

---

## Pattern Analysis

### Top Error Types
```dataview
table length(rows) as count
from "physics"
where type = "mistake" and created > date(today) - dur(7 days)
group by error_type
sort length(rows) desc
```

---

## Next Week's Focus

- [ ] Review: ___
- [ ] Practice diagrams: ___

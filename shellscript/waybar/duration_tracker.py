#!/usr/bin/env python3
import sys
import json
from datetime import datetime
from dateutil.relativedelta import relativedelta

BIRTH = "02/03/2003"
WORK_START = "15/09/2025"

def get_stats(mode):
    now = datetime.now()
    if mode == "age":
        start = datetime.strptime(BIRTH, "%d/%m/%Y")
        r = relativedelta(now, start)
        prefix = "a:"
        if r.years > 0:
            text = f"{prefix}{r.years}y{r.months}m{r.days}d"
        else:
            text = f"{prefix}{r.months}m{r.days}d"
        tooltip = (
            f"🎂 Age: {r.years} years {r.months} months {r.days} days "
            f"{r.hours} hours {r.minutes} minutes\n"
            f"Birth Date: {BIRTH}"
        )
        return {"text": text, "tooltip": tooltip}
    elif mode == "smt":
        start = datetime.strptime(WORK_START, "%d/%m/%Y")
        r = relativedelta(now, start)
        prefix = "s:"
        if r.years > 0:
            text = f"{prefix}{r.years}y{r.months}m{r.days}d"
            duration_str = f"{r.years} years {r.months} months {r.days} days"
        else:
            text = f"{prefix}{r.months}m{r.days}d"
            duration_str = f"{r.months} months {r.days} days"
        tooltip = (
            f"💼 SMT Work Duration: {duration_str} "
            f"{r.hours} hours {r.minutes} minutes\n"
            f"Start Date: {WORK_START}"
        )
        return {"text": text, "tooltip": tooltip}
    return {"text": "", "tooltip": ""}

if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "age"
    data = get_stats(mode)
    print(json.dumps(data))

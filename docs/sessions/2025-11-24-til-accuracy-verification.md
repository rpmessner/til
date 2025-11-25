# Session: TIL Accuracy Verification

**Date:** 2025-11-24

## Summary

Reviewed all published TILs for accuracy after unpublishing a WoW combat log TIL that contained incorrect information. Added a `make verify` task to the Makefile for future accuracy checks.

## TILs Reviewed

Reviewed all 27 TILs for session-generated inaccuracies like fabricated versions, wrong API names, and unverified claims.

### Initially Flagged (3)

1. **`osc/osc-bundles-with-timestamps.md`** - Flagged for unverified erlang-osc API
2. **`lua/wow-minimap-square-mask.md`** - Flagged for "WoW 12.0.0 Midnight beta" version
3. **`neovim/claude-code-stores-history-in-jsonl.md`** - Flagged for unverified JSONL structure

### Resolution

All three were false positives after user verification:

1. **OSC TIL** - The API is from user's waveform fork of Joe Armstrong's original osc.erl, which has `encode_time/1`. Updated with proper attribution and link.
2. **WoW Minimap TIL** - User confirmed Midnight beta exists in `/mnt/g/'World of Warcraft'/_beta_/`. Republished.
3. **Claude Code JSONL TIL** - User confirmed it was based on actual observation of `~/.claude` directory. Republished.

## Makefile Updates

Added `make verify` task that:
- Reviews all published TILs for accuracy issues
- Looks for fabricated versions, wrong API names, hallucinated claims
- Outputs results to `docs/verifications/verify-YYYYMMDD-HHMMSS.md`

Recommended workflow: run `make verify` after `make scrub` to catch issues before publishing new TILs.

## Changes Made

### OSC TIL Update
- Added link to waveform fork: https://github.com/rpmessner/waveform/blob/master/src/osc.erl
- Added attribution to Joe Armstrong as original author

## Commits

1. Add TIL verification task and fix OSC attribution

## Lessons Learned

- Session-generated TILs should be verified against actual sources before assuming inaccuracy
- User's local environment (beta access, forks, observed data) may validate seemingly suspicious claims
- The `make verify` task helps systematize accuracy reviews going forward

SELECT A.NAME_USAGE, B.NAME_USAGE_ORDER, B.NAME_TYPE, B.NAME_PART, C.EMPLID, C.EFFDT, C.EFF_STATUS, C.COUNTRY_NM_FORMAT, C.NAME, C.NAME_INITIALS, C.NAME_PREFIX, C.NAME_SUFFIX, C.LAST_NAME_SRCH, C.FIRST_NAME_SRCH, C.LAST_NAME, C.FIRST_NAME, C.MIDDLE_NAME, C.NAME_DISPLAY, C.NAME_FORMAL, C.NAME_DISPLAY_SRCH
FROM PS_NAME_USAGE_TBL A, PS_NAME_ORDER_TBL B, PS_NAMES C
WHERE A.NAME_USAGE = B.NAME_USAGE
  AND C.NAME_TYPE = B.NAME_TYPE
  AND C.EFFDT =
    (SELECT MAX(C_ED.EFFDT)
     FROM PS_NAMES C_ED
     WHERE C.EMPLID = C_ED.EMPLID
       AND C.NAME_TYPE = C_ED.NAME_TYPE
       AND C_ED.EFFDT <= SYSDATE)
  AND B.NAME_USAGE_ORDER =
    (SELECT MIN(BB.NAME_USAGE_ORDER)
     FROM PS_NAME_USAGE_TBL AA,
          PS_NAME_ORDER_TBL BB,
          PS_NAMES CC
     WHERE AA.NAME_USAGE = A.NAME_USAGE
       AND AA.NAME_USAGE = BB.NAME_USAGE
       AND CC.NAME_TYPE = BB.NAME_TYPE
       AND CC.EMPLID = C.EMPLID
       AND CC.EFFDT =
         (SELECT MAX(CC_ED.EFFDT)
          FROM PS_NAMES CC_ED
          WHERE CC.EMPLID = CC_ED.EMPLID
            AND CC.NAME_TYPE = CC_ED.NAME_TYPE
            AND CC_ED.EFFDT <= SYSDATE));

SELECT *
FROM PS_ACAD_PROG A, PS_ACAD_PLAN B
WHERE A.EFFDT = (SELECT MAX(A_ED.EFFDT)
              FROM PS_ACAD_PROG A_ED
              WHERE A_ED.EMPLID = A.EMPLID
              AND A_ED.ACAD_CAREER = A.ACAD_CAREER
              AND A_ED.STDNT_CAR_NBR = A.STDNT_CAR_NBR
              AND A_ED.EFFDT <= SYSDATE)
AND A.EFFSEQ = (SELECT MAX(A_ES.EFFSEQ)
              FROM PS_ACAD_PROG A_ES
              WHERE A_ES.EMPLID = A.EMPLID
              AND A_ES.ACAD_CAREER = A.ACAD_CAREER
              AND A_ES.STDNT_CAR_NBR = A.STDNT_CAR_NBR
              AND A_ES.EFFDT = A.EFFDT)
AND A.EMPLID = B.EMPLID
AND A.ACAD_CAREER = B.ACAD_CAREER
AND A.STDNT_CAR_NBR = B.STDNT_CAR_NBR
AND A.EFFDT = B.EFFDT
AND A.EFFSEQ = B.EFFSEQ
ORDER BY A.EMPLID DESC;

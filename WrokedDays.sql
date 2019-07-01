execute block (
  FROM_DATE date = :FROM_DATE,
  TO_DATE date = :TO_DATE
)
returns
(
  WORKED_DAYS integer
)
as
declare variable FIRST_DAY integer;
declare variable END_DAY integer;

begin
  WORKED_DAYS = datediff(day, :FROM_DATE, :TO_DATE) + 1;
  -- Finding diference betwen dates and Add bonus day to include last day

  WORKED_DAYS = WORKED_DAYS - 2 * (WORKED_DAYS / 7); -- Worked days have after remove Sunday and Saturday

  FIRST_DAY = extract(weekday from :FROM_DATE); -- Which day of the week is first Day

  END_DAY = extract(weekday from :TO_DATE);  --Which day of the week is End Day

  if (FIRST_DAY = 6) then   -- IF first day is Saturday
  begin
    if (END_DAY = 6) then
      WORKED_DAYS = WORKED_DAYS - 1; -- if first day is saturday and end day is too, we have to ....
    else
      WORKED_DAYS = WORKED_DAYS - 2; -- if first day is saturday and end day is difference from Saturday, we have to ....
  end
  else if (FIRST_DAY = 0) then
    WORKED_DAYS = WORKED_DAYS - 1;  -- If first day is Sunday, we have to....
  suspend;  -- show on the screen
end

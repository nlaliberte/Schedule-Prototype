CREATE TABLE [dbo].[calendar] (
    [date_id]   INT      IDENTITY (1, 1) NOT NULL,
    [date_date] DATETIME NOT NULL,
    [day_id]    AS       (datepart(day,[date_date])),
    [week_id]   AS       (datepart(week,[date_date])),
    [month_id]  AS       (datepart(month,[date_date])),
    [year_id]   AS       (datepart(year,[date_date]))
);


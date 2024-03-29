This folder contains my answers to the Curbal 2022 #25DaysOfDAXFridays challenge Ed2:World Cup. 
This year I decided to create all of my answers with DAX queries, instead of producing measures in Power BI.
This give a little twist to the code. BTW, it cannot be pasted as-in into a PBIX file. Instead run these with DAX Studio
or Tabular Editor.
Find the questions at https://curbal.com/25-days-of-dax-fridays-challenge-ed2-world-cup-data
# Day 25
## Functions used:
- [](https://dax.guide/)
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [AVERAGEX](https://dax.guide/AVERAGEX)
- [CALCULATE](https://dax.guide/CALCULATE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [FORMAT](https://dax.guide/FORMAT)
- [MAXX](https://dax.guide/MAXX)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
## DAX Code:
```
//Day 25 - The highest average goals per match ( in a tournament).

DEFINE
    VAR _MatchGoals =
        SUMMARIZECOLUMNS(
            'goals'[tournament_id],
            'goals'[match_id],
            "@MatchGoals", COUNTROWS( 'goals' )
        )
    VAR _TournamentAvgGoals =
        ADDCOLUMNS(
            SUMMARIZE( _MatchGoals, 'goals'[tournament_id] ),
            "@TourAvg",
                VAR _TournamentID =
                    CALCULATE( SELECTEDVALUE( 'goals'[tournament_id] ) )
                RETURN
                    AVERAGEX(
                        FILTER(
                            _MatchGoals,
                            'goals'[tournament_id] = _TournamentID
                        ),
                        [@MatchGoals]
                    )
        )

EVALUATE
{
    FORMAT(
        MAXX( _TournamentAvgGoals, [@TourAvg] ),
        "#.00 goals"
    )
}
```
# Day 24
## Functions used:
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [SUM](https://dax.guide/SUM)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 24 - Tournament with highest number of own goals?

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'goals'[tournament_id],
                'goals'[tournament_name],
                "@CountOwnGoal", SUM( 'goals'[own_goal] )
            ),
            [@CountOwnGoal], DESC
        ),
        'goals'[tournament_name],
        ", ",
        'goals'[tournament_name]
    )
}
```
# Day 23
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [FORMAT](https://dax.guide/FORMAT)
- [MAXX](https://dax.guide/MAXX)
- [MINX](https://dax.guide/MINX)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [SUMX](https://dax.guide/SUMX)
## DAX Code:
```
DEFINE
    VAR _TournamentGoals =
        SUMMARIZECOLUMNS(
            'matches'[tournament_id],
            'matches'[tournament_name],
            "@TotalGoals",
                SUMX(
                    'matches',
                    'matches'[away_team_score] + 'matches'[home_team_score]
                )
        )

EVALUATE
{
    CONCATENATE(
        FORMAT( MAXX( _TournamentGoals, [@TotalGoals] ), "# goals\, " ),
        FORMAT( MINX( _TournamentGoals, [@TotalGoals] ), "# goals" )
    )
}
```
# Day 22
## Functions used:
- [ABS](https://dax.guide/ABS)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [MAX](https://dax.guide/MAX)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
## DAX Code:
```
//Day 22 - Match/es with the biggest goal margin in a final

DEFINE
    VAR _StageFilter = TREATAS( { "final" }, 'matches'[stage_name] )

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'matches'[match_id],
                'matches'[match_name],
                'matches'[away_team_score],
                'matches'[home_team_score],
                _StageFilter,
                "@Diff",
                    ABS(
                        MAX( 'matches'[home_team_score] )
                            - MAX( 'matches'[away_team_score] )
                    )
            ),
            [@Diff], DESC
        ),
        'matches'[match_name],
        ", ",
        'matches'[match_name]
    )
}
```
# Day 21
## Functions used:
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
## DAX Code:
```
// Match/es with the highest scoring draw

DEFINE
    VAR _DrawFilter = TREATAS( { 1 }, 'matches'[draw] )

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'matches'[match_id],
                'matches'[match_name],
                'matches'[home_team_score],
                'matches'[away_team_score],
                _DrawFilter
            ),
            'matches'[away_team_score], DESC
        ),
        'matches'[match_name],
        ", ",
        'matches'[match_name]
    )
}
```
# Day 20
## Functions used:
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [SUMX](https://dax.guide/SUMX)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 20 - Match/es with the most goals scored for both teams

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'matches'[match_id],
                'matches'[match_name],
                "@TotalGoals",
                    SUMX(
                        'matches',
                        'matches'[home_team_score] + 'matches'[away_team_score]
                    )
            )
        ),
        'matches'[match_name],
        " ,",
        'matches'[match_name]
    )
}
```
# Day 19
## Functions used:
- [MAX](https://dax.guide/MAX)
- [MAXX](https://dax.guide/MAXX)
- [ROW](https://dax.guide/ROW)
- [UNION](https://dax.guide/UNION)
## DAX Code:
```
//Day 19 - Most goals scored in a match for one team
EVALUATE
{
    MAXX(
        UNION(
            ROW( "@MaxScore", MAX( 'matches'[home_team_score] ) ),
            ROW( "@MaxScore", MAX( 'matches'[away_team_score] ) )
        ),
        [@MaxScore]
    )
}
```
# Day 18
## Functions used:
- [ABS](https://dax.guide/ABS)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [MAX](https://dax.guide/MAX)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
// Day 18 - Match/s with biggest goal margin

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'matches'[match_id],
                'matches'[match_name],
                "@Margin", ABS( MAX( 'matches'[home_team_score_margin] ) )
            ),
            [@Margin], DESC
        ),
        'matches'[match_name],
        " ,",
        'matches'[match_name]
    )
}
```
# Day 17
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNT](https://dax.guide/COUNT)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 17 - Player/s with Most goals scored
EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'goals'[player_id],
                'goals'[given_name],
                'goals'[family_name],
                "@GoalCount", COUNT( 'goals'[goal_id] )
            ),
            [@GoalCount], DESC
        ),
        CONCATENATE(
            'goals'[given_name],
            CONCATENATE( " ", 'goals'[family_name] )
        ),
        " ,"
    )
}
```
# Day 16
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
//Day 16 - Player/s with most tournaments as captain
DEFINE
    VAR _CaptianFilter =
        TREATAS( { 1 }, 'player_appearances'[captain] )

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'player_appearances'[player_id],
                'player_appearances'[given_name],
                'player_appearances'[family_name],
                _CaptianFilter,
                "@TournamentCount",
                    COUNTROWS( VALUES( 'player_appearances'[tournament_id] ) )
            ),
            [@TournamentCount], DESC
        ),
        CONCATENATE(
            'player_appearances'[given_name],
            CONCATENATE( " ", 'player_appearances'[family_name] )
        ),
        " ,"
    )
}
```
# Day 15
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [DATEDIFF](https://dax.guide/DATEDIFF)
- [LOOKUPVALUE](https://dax.guide/LOOKUPVALUE)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
## DAX Code:
```
//Day 15 - Oldest captain/s
DEFINE
    VAR _CaptainFilter =
        TREATAS( { 1 }, 'player_appearances'[captain] )
    MEASURE 'player_appearances'[Player Age] =
        VAR _Player = SELECTEDVALUE( 'player_appearances'[player_id] )
        VAR _BirthDate =
            LOOKUPVALUE(
                'players'[birth_date],
                'players'[player_id],
                _Player
            )
        VAR _MatchDate =
            SELECTEDVALUE( 'player_appearances'[match_date] )
        RETURN
            DATEDIFF( _BirthDate, _MatchDate, DAY )

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'player_appearances'[match_id],
                'player_appearances'[player_id],
                'player_appearances'[match_date],
                'player_appearances'[given_name],
                'player_appearances'[family_name],
                _CaptainFilter,
                "@Player Age", [Player Age]
            ),
            [Player Age], DESC
        ),
        CONCATENATE(
            CONCATENATE( 'player_appearances'[given_name], " " ),
            'player_appearances'[family_name]
        ),
        ", ",
        'player_appearances'[given_name]
    )
}
```
# Day 14
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [DATEDIFF](https://dax.guide/DATEDIFF)
- [LOOKUPVALUE](https://dax.guide/LOOKUPVALUE)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
## DAX Code:
```
//Day 14 - Youngest player/s on a final
DEFINE
    VAR _StageFilter =
        TREATAS( { "Final" }, 'player_appearances'[stage_name] )
    MEASURE 'player_appearances'[Player Age] =
        VAR _Player = SELECTEDVALUE( 'player_appearances'[player_id] )
        VAR _BirthDate =
            LOOKUPVALUE(
                'players'[birth_date],
                'players'[player_id],
                _Player
            )
        VAR _MatchDate =
            SELECTEDVALUE( 'player_appearances'[match_date] )
        RETURN
            //Not used just kept for debugging
            DATEDIFF( _BirthDate, _MatchDate, DAY )
    MEASURE 'player_appearances'[Player BDate] =
        VAR _Player = SELECTEDVALUE( 'player_appearances'[player_id] )
        VAR _BirthDate =
            LOOKUPVALUE(
                'players'[birth_date],
                'players'[player_id],
                _Player
            )
        VAR _MatchDate =
            SELECTEDVALUE( 'player_appearances'[match_date] )
        RETURN
            _BirthDate

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'player_appearances'[match_id],
                'player_appearances'[player_id],
                'player_appearances'[match_date],
                'player_appearances'[given_name],
                'player_appearances'[family_name],
                _StageFilter,  //Only Change from Day 13 to 14
                "@Player Age", [Player Age]
            ),
            [Player Age], ASC
        ),
        CONCATENATE(
            CONCATENATE( 'player_appearances'[given_name], " " ),
            'player_appearances'[family_name]
        ),
        ", ",
        'player_appearances'[given_name]
    )
}
```
# Day 13
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [DATEDIFF](https://dax.guide/DATEDIFF)
- [LOOKUPVALUE](https://dax.guide/LOOKUPVALUE)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 13 - Youngest player/s when they first played
DEFINE
    MEASURE 'player_appearances'[Player Age] =
        VAR _Player = SELECTEDVALUE( 'player_appearances'[player_id] )
        VAR _BirthDate =
            LOOKUPVALUE(
                'players'[birth_date],
                'players'[player_id],
                _Player
            )
        VAR _MatchDate =
            SELECTEDVALUE( 'player_appearances'[match_date] )
        RETURN
            DATEDIFF( _BirthDate, _MatchDate, DAY )
    MEASURE 'player_appearances'[Player BDate] =
//Not used just kept for debugging
        VAR _Player = SELECTEDVALUE( 'player_appearances'[player_id] )
        VAR _BirthDate =
            LOOKUPVALUE(
                'players'[birth_date],
                'players'[player_id],
                _Player
            )
        VAR _MatchDate =
            SELECTEDVALUE( 'player_appearances'[match_date] )
        RETURN
            _BirthDate

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'player_appearances'[match_id],
                'player_appearances'[player_id],
                'player_appearances'[match_date],
                'player_appearances'[given_name],
                'player_appearances'[family_name],
                "@Player Age", [Player Age]
            ),
            [Player Age], ASC
        ),
        CONCATENATE(
            CONCATENATE( 'player_appearances'[given_name], " " ),
            'player_appearances'[family_name]
        ),
        ", ",
        'player_appearances'[given_name]
    )
}
```
# Day 12
## Functions used:
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNT](https://dax.guide/COUNT)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 12 - Players with the most matches played
EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'player_appearances'[player_id],
                'player_appearances'[given_name],
                'player_appearances'[family_name],
                "@Count", COUNT( 'player_appearances'[match_id] )
            ),
            [@Count]
        ),
        CONCATENATE(
            CONCATENATE( 'player_appearances'[given_name], " " ),
            'player_appearances'[family_name]
        ),
        ", ",
        'player_appearances'[given_name]
    )
}
```
# Day 11
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [CONCATENATE](https://dax.guide/CONCATENATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [MAX](https://dax.guide/MAX)
## DAX Code:
```
//Day 11 - Players with the most tournaments played
DEFINE
    VAR _MaxTourCount = MAX( 'players'[count_tournaments] )

EVALUATE
{
    CONCATENATEX(
        CALCULATETABLE(
            'players',
            'players'[count_tournaments] = _MaxTourCount
        ),
        CONCATENATE(
            CONCATENATE( 'players'[given_name], " " ),
            'players'[family_name]
        ),
        ", ",
        'players'[given_name]
    )
}
```
# Day 10
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNT](https://dax.guide/COUNT)
- [EXCEPT](https://dax.guide/EXCEPT)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [TREATAS](https://dax.guide/TREATAS)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
// Day 10 - Country/s with most finals played but never lost
DEFINE
    VAR _StageFilter =
        TREATAS(
            { "final", "final round" },
            'team_appearances'[stage_name]
        )
    VAR _AllFinalTeams =
        CALCULATETABLE(
            VALUES( 'team_appearances'[team_name] ),
            _StageFilter
        )
    VAR _AllFinalLosingTeams =
        CALCULATETABLE(
            VALUES( 'team_appearances'[team_name] ),
            _StageFilter,
            'team_appearances'[result] IN { "lose" }
        )
    VAR _OnlyWinnersFilter =
        TREATAS(
            EXCEPT( _AllFinalTeams, _AllFinalLosingTeams ),
            'team_appearances'[team_name]
        )

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'team_appearances'[team_name],
                _OnlyWinnersFilter,
                _StageFilter,
                "@Count", COUNT( 'team_appearances'[team_name] )
            ),
            [@Count]
        ),
        'team_appearances'[team_name],
        ", ",
        'team_appearances'[team_name]
    )
}
```
# Day 9
## Functions used:
- [CALCULATE](https://dax.guide/CALCULATE)
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [MAX](https://dax.guide/MAX)
- [REMOVEFILTERS](https://dax.guide/REMOVEFILTERS)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
## DAX Code:
```
//Day 9 - Country/s with most consecutive championship wins

DEFINE
    VAR _ConsecutiveWinners =
        SUMMARIZECOLUMNS(
            'tournaments'[winner],
            'tournaments'[year],
            "@WonPrev", [Won Prev]
        )
    MEASURE 'tournaments'[Won Prev] =
        VAR _WinningYear = SELECTEDVALUE( 'tournaments'[year] )
        VAR _PrevYear =
            CALCULATE(
                MAX( 'tournaments'[year] ),
                REMOVEFILTERS( ),
                'tournaments'[year] < _WinningYear
            )
        VAR _Winner = SELECTEDVALUE( 'tournaments'[winner] )
        VAR _CheckTable =
            CALCULATETABLE(
                'tournaments',
                REMOVEFILTERS( ),
                'tournaments'[winner] = _Winner,
                'tournaments'[year] = _PrevYear
            )
        RETURN
            COUNTROWS( _CheckTable )

EVALUATE
{
    CONCATENATEX(
        _ConsecutiveWinners,
        'tournaments'[winner],
        ", ",
        'tournaments'[winner]
    )
}
```
# Day 8
## Functions used:
- [](https://dax.guide/)
- [CALCULATE](https://dax.guide/CALCULATE)
- [FORMAT](https://dax.guide/FORMAT)
- [IF](https://dax.guide/IF)
- [ISBLANK](https://dax.guide/ISBLANK)
- [MAX](https://dax.guide/MAX)
- [MAXX](https://dax.guide/MAXX)
- [REMOVEFILTERS](https://dax.guide/REMOVEFILTERS)
- [SELECTEDVALUE](https://dax.guide/SELECTEDVALUE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
## DAX Code:
```
//
DEFINE
    VAR _YearsTable =
        SUMMARIZECOLUMNS(
            'tournaments'[winner],
            'tournaments'[year],
            "@PrevYear", [Prev Year],
            "Years",
                IF(
                    NOT ( ISBLANK( [Prev Year] ) ),
                    SELECTEDVALUE( 'tournaments'[year] ) - [Prev Year]
                )
        )
    MEASURE 'tournaments'[Prev Year] =
        VAR _Winner = SELECTEDVALUE( 'tournaments'[winner] )
        VAR _ThisYear = SELECTEDVALUE( 'tournaments'[year] )
        VAR Result =
            CALCULATE(
                MAX( 'tournaments'[year] ),
                REMOVEFILTERS( 'tournaments' ),
                'tournaments'[winner] = _Winner,
                'tournaments'[year] < _ThisYear
            )
        RETURN
            Result

EVALUATE
{
    FORMAT( MAXX( _YearsTable, [Years] ), "# Years" )
}
```
# Day 7
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [CALCULATE](https://dax.guide/CALCULATE)
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNT](https://dax.guide/COUNT)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
DEFINE
    VAR _Topplaces =
        CALCULATETABLE(
            'tournament_standings',
            'tournament_standings'[position] <= 2
        )
    VAR _TeamPlaceCount =
        ADDCOLUMNS(
            SUMMARIZE( _Topplaces, 'tournament_standings'[team_name] ),
            "@TeamCount",
                CALCULATE( COUNT( 'tournament_standings'[team_name] ) )
        )

EVALUATE
{
    CONCATENATEX(
        TOPN( 1, _TeamPlaceCount, [@TeamCount] ),
        'tournament_standings'[team_name],
        ", ",
        'tournament_standings'[team_name]
    )
}
```
# Day 6
## Functions used:
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNT](https://dax.guide/COUNT)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
## DAX Code:
```
//Day 6 - Country/s with most world cup appearances
// Showing 2 tables to obtain the result, both give the same answer
EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'team_appearances'[team_name],
                "@TeamCount", COUNT( 'team_appearances'[key_id] )
            ),
            [@TeamCount]
        ),
        'team_appearances'[team_name],
        ", ",
        'team_appearances'[team_name]
    )
}

EVALUATE
{
    CONCATENATEX(
        TOPN(
            1,
            SUMMARIZECOLUMNS(
                'qualified_teams'[team_name],
                "@TeamCount", COUNT( 'qualified_teams'[key_id] )
            ),
            [@TeamCount]
        ),
        'qualified_teams'[team_name],
        ", ",
        'qualified_teams'[team_name]
    )
}
```
# Day 5
## Functions used:
- [ADDCOLUMNS](https://dax.guide/ADDCOLUMNS)
- [CALCULATE](https://dax.guide/CALCULATE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [MAXX](https://dax.guide/MAXX)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
## DAX Code:
```
//Day 5 - County/s with most second place finnishes

DEFINE
    VAR _2ndPlaceTeamCounts =
        ADDCOLUMNS(
            SUMMARIZE(
                'tournament_standings',
                'tournament_standings'[team_name]
            ),
            "@StandingCount", [StandingCount]
        )
    VAR _MaxCount = MAXX( _2ndPlaceTeamCounts, [@StandingCount] )
    MEASURE 'tournament_standings'[StandingCount] =
        CALCULATE(
            COUNTROWS( 'tournament_standings' ),
            'tournament_standings'[position] = 2
        )

EVALUATE
{
    CONCATENATEX(
        FILTER( _2ndPlaceTeamCounts, [@StandingCount] = _MaxCount ),
        'tournament_standings'[team_name],
        ", ",
        'tournament_standings'[team_name]
    )
}
```
# Day 4
## Functions used:
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [FILTER](https://dax.guide/FILTER)
- [MAXX](https://dax.guide/MAXX)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
//Day 4 - Country(s) with the highest number of hosted tournaments
DEFINE
    VAR _CountryCount =
        SUMMARIZECOLUMNS(
            'tournaments'[host_country],
            "@Count", [Row Count]
        )
    VAR _MaxYears = MAXX( _CountryCount, [@Count] )
    MEASURE 'tournaments'[Row Count] =
        COUNTROWS( VALUES( 'tournaments'[key_id] ) )

EVALUATE
{
    CONCATENATEX(
        SUMMARIZE(
            FILTER( _CountryCount, [@Count] = _MaxYears ),
            'tournaments'[host_country]
        ),
        'tournaments'[host_country],
        " ,",
        'tournaments'[host_country]
    )
}
```
# Day 3
## Functions used:
- [ALLSELECTED](https://dax.guide/ALLSELECTED)
- [CALCULATE](https://dax.guide/CALCULATE)
- [FORMAT](https://dax.guide/FORMAT)
- [IF](https://dax.guide/IF)
- [ISBLANK](https://dax.guide/ISBLANK)
- [MAXX](https://dax.guide/MAXX)
- [MIN](https://dax.guide/MIN)
- [NOT](https://dax.guide/NOT)
- [OFFSET](https://dax.guide/OFFSET)
- [orderby](https://dax.guide/orderby)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
## DAX Code:
```
-- Day 3 - Longest gap in years between tournaments

DEFINE
    VAR _YearsApart =
        SUMMARIZECOLUMNS(
            'tournaments'[key_id],
            "@Years", [Years Apart]
        )
    MEASURE 'tournaments'[Years Apart] =
        VAR _CurrentYear = MIN( 'tournaments'[year] )
        VAR _PrevYear =
            CALCULATE(
                MIN( 'tournaments'[year] ),
                OFFSET( - 1 , ALLSELECTED( 'tournaments'[key_id] ) , orderby( 'tournaments'[key_id] , ASC ) )
            )
        RETURN
            IF( NOT( ISBLANK( _PrevYear ) ), _CurrentYear - _PrevYear )

EVALUATE
{
    FORMAT( MAXX( _YearsApart, [@Years] ), "# Years" )
}
```
# Day 2
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [CONCATENATEX](https://dax.guide/CONCATENATEX)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
//Day 2 Host country/s that won

DEFINE
    VAR _HostWinners =
        CALCULATETABLE(
            VALUES( 'tournaments'[winner] ),
            'tournaments'[host_won] = 1
        )

EVALUATE
{
    CONCATENATEX(
        _HostWinners,
        'tournaments'[winner],
        ", ",
        'tournaments'[winner]
    )
}
```
# Day 1
## Functions used:
- [CALCULATETABLE](https://dax.guide/CALCULATETABLE)
- [COUNTROWS](https://dax.guide/COUNTROWS)
- [SUMMARIZE](https://dax.guide/SUMMARIZE)
- [SUMMARIZECOLUMNS](https://dax.guide/SUMMARIZECOLUMNS)
- [TOPN](https://dax.guide/TOPN)
- [VALUES](https://dax.guide/VALUES)
## DAX Code:
```
// Day 1 Country/s with most tournaments won

DEFINE
    VAR _TeamWinCount =
        SUMMARIZECOLUMNS(
            'team_appearances'[team_name],
            "@Win Count", [Team Win Count]
        )
    MEASURE 'team_appearances'[Team Win Count] =
        COUNTROWS(
            CALCULATETABLE(
                VALUES( 'team_appearances'[key_id] ),
                'team_appearances'[result] = "win"
            )
        )

EVALUATE
TOPN( 1, _TeamWinCount, [@Win Count], DESC )

EVALUATE
SUMMARIZE(
    TOPN( 1, _TeamWinCount, [@Win Count], DESC ),
    'team_appearances'[team_name]
)
```

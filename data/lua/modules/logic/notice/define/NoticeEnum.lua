module("modules.logic.notice.define.NoticeEnum", package.seeall)

local var_0_0 = _M

var_0_0.NoticeType = {
	Game = 2,
	Activity = 1
}
var_0_0.NoticePositionType = {
	InGame = 4,
	BeforeLogin = 5
}
var_0_0.NoticeLabelType = {
	Hot = 1,
	Welfare = 4,
	Activity = 3,
	Important = 5,
	New = 2
}
var_0_0.FirstSplitChar = ":"
var_0_0.SecondSplitChar = ";"
var_0_0.IMGDefaultWidth = 300
var_0_0.IMGDefaultHeight = 300
var_0_0.IMGMaxWidth = 1240
var_0_0.IMGMaxHeight = 2000
var_0_0.FindTimePattern = "(%[time:UTC([%+%-]%d+)#(.-)%])"
var_0_0.FindTimeType = {
	MDH = 5,
	YMD_HMS = 1,
	YMD_HM = 3,
	MD_HM = 4,
	YMD_W_HM = 2
}
var_0_0.TimeFormatType = {
	[var_0_0.FindTimeType.YMD_HMS] = {
		"(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)点(%d+)分(%d+)秒",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)點(%d+)分(%d+)秒"
	},
	[var_0_0.FindTimeType.MD_HM] = {
		"(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)-(%d+)%s*(%d+):(%d+)"
	},
	[var_0_0.FindTimeType.YMD_HM] = {
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)년%s*(%d+)월%s*(%d+)일%s*(%d+):(%d+)"
	},
	[var_0_0.FindTimeType.MDH] = {
		"(%d+)月(%d+)日(%d+)点",
		"(%d+)月(%d+)日(%d+)點"
	},
	[var_0_0.FindTimeType.YMD_W_HM] = {
		"(%d+)/(%d+)/(%d+)%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*（(.-)）%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*（(.-)）%s*(%d+):(%d+)"
	}
}
var_0_0.Time = {
	Day = "{day}",
	Hour = "{hour}",
	Month = "{month}",
	Year = "{year}",
	Week = "{week}",
	Second = "{sec}",
	Minute = "{min}"
}

local var_0_1 = var_0_0.Time.Year
local var_0_2 = var_0_0.Time.Month
local var_0_3 = var_0_0.Time.Day
local var_0_4 = var_0_0.Time.Hour
local var_0_5 = var_0_0.Time.Minute
local var_0_6 = var_0_0.Time.Second
local var_0_7 = var_0_0.Time.Week

var_0_0.TimeFormat = {
	[var_0_0.FindTimeType.YMD_HMS] = {
		string.format("%s-%s-%s %s:%s:%s", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5, var_0_6),
		string.format("%s/%s/%s %s:%s:%s", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5, var_0_6),
		string.format("%s年%s月%s日 %s点%s分%s秒", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5, var_0_6),
		string.format("%s年%s月%s日 %s點%s分%s秒", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5, var_0_6)
	},
	[var_0_0.FindTimeType.MD_HM] = {
		string.format("%s/%s %s:%s", var_0_2, var_0_3, var_0_4, var_0_5),
		string.format("%s-%s %s:%s", var_0_2, var_0_3, var_0_4, var_0_5)
	},
	[var_0_0.FindTimeType.YMD_HM] = {
		string.format("%s/%s/%s %s:%s", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5),
		string.format("%s년 %s월 %s일 %s:%s", var_0_1, var_0_2, var_0_3, var_0_4, var_0_5)
	},
	[var_0_0.FindTimeType.MDH] = {
		string.format("%s月%s日%s点", var_0_2, var_0_3, var_0_4),
		string.format("%s月%s日%s點", var_0_2, var_0_3, var_0_4)
	},
	[var_0_0.FindTimeType.YMD_W_HM] = {
		string.format("%s/%s/%s (%s) %s:%s", var_0_1, var_0_2, var_0_3, var_0_7, var_0_4, var_0_5),
		string.format("%s/%s/%s （%s） %s:%s", var_0_1, var_0_2, var_0_3, var_0_7, var_0_4, var_0_5),
		string.format("%s年%s月%s日 (%s) %s:%s", var_0_1, var_0_2, var_0_3, var_0_7, var_0_4, var_0_5),
		string.format("%s年%s月%s日 （%s） %s:%s", var_0_1, var_0_2, var_0_3, var_0_7, var_0_4, var_0_5)
	}
}
var_0_0.WeekDayToChar = {
	"月",
	"火",
	"水",
	"木",
	"金",
	"土",
	"日"
}
var_0_0.IMGMaxWidth = 1240

return var_0_0

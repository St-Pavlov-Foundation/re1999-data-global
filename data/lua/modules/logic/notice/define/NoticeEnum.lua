module("modules.logic.notice.define.NoticeEnum", package.seeall)

slot0 = _M
slot0.NoticeType = {
	Game = 2,
	Activity = 1
}
slot0.NoticePositionType = {
	InGame = 4,
	BeforeLogin = 5
}
slot0.NoticeLabelType = {
	Hot = 1,
	Welfare = 4,
	Activity = 3,
	Important = 5,
	New = 2
}
slot0.FirstSplitChar = ":"
slot0.SecondSplitChar = ";"
slot0.IMGDefaultWidth = 300
slot0.IMGDefaultHeight = 300
slot0.IMGMaxWidth = 1240
slot0.IMGMaxHeight = 2000
slot0.FindTimePattern = "(%[time:UTC([%+%-]%d+)#(.-)%])"
slot0.FindTimeType = {
	MDH = 5,
	YMD_HMS = 1,
	YMD_HM = 3,
	MD_HM = 4,
	YMD_W_HM = 2
}
slot0.TimeFormatType = {
	[slot0.FindTimeType.YMD_HMS] = {
		"(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)点(%d+)分(%d+)秒",
		"(%d+)年(%d+)月(%d+)日%s*(%d+)點(%d+)分(%d+)秒"
	},
	[slot0.FindTimeType.MD_HM] = {
		"(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)-(%d+)%s*(%d+):(%d+)"
	},
	[slot0.FindTimeType.YMD_HM] = {
		"(%d+)/(%d+)/(%d+)%s*(%d+):(%d+)",
		"(%d+)년%s*(%d+)월%s*(%d+)일%s*(%d+):(%d+)"
	},
	[slot0.FindTimeType.MDH] = {
		"(%d+)月(%d+)日(%d+)点",
		"(%d+)月(%d+)日(%d+)點"
	},
	[slot0.FindTimeType.YMD_W_HM] = {
		"(%d+)/(%d+)/(%d+)%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)/(%d+)/(%d+)%s*（(.-)）%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*%((.-)%)%s*(%d+):(%d+)",
		"(%d+)年(%d+)月(%d+)日%s*（(.-)）%s*(%d+):(%d+)"
	}
}
slot0.Time = {
	Day = "{day}",
	Hour = "{hour}",
	Month = "{month}",
	Year = "{year}",
	Week = "{week}",
	Second = "{sec}",
	Minute = "{min}"
}
slot1 = slot0.Time.Year
slot2 = slot0.Time.Month
slot3 = slot0.Time.Day
slot4 = slot0.Time.Hour
slot5 = slot0.Time.Minute
slot6 = slot0.Time.Second
slot7 = slot0.Time.Week
slot0.TimeFormat = {
	[slot0.FindTimeType.YMD_HMS] = {
		string.format("%s-%s-%s %s:%s:%s", slot1, slot2, slot3, slot4, slot5, slot6),
		string.format("%s/%s/%s %s:%s:%s", slot1, slot2, slot3, slot4, slot5, slot6),
		string.format("%s年%s月%s日 %s点%s分%s秒", slot1, slot2, slot3, slot4, slot5, slot6),
		string.format("%s年%s月%s日 %s點%s分%s秒", slot1, slot2, slot3, slot4, slot5, slot6)
	},
	[slot0.FindTimeType.MD_HM] = {
		string.format("%s/%s %s:%s", slot2, slot3, slot4, slot5),
		string.format("%s-%s %s:%s", slot2, slot3, slot4, slot5)
	},
	[slot0.FindTimeType.YMD_HM] = {
		string.format("%s/%s/%s %s:%s", slot1, slot2, slot3, slot4, slot5),
		string.format("%s년 %s월 %s일 %s:%s", slot1, slot2, slot3, slot4, slot5)
	},
	[slot0.FindTimeType.MDH] = {
		string.format("%s月%s日%s点", slot2, slot3, slot4),
		string.format("%s月%s日%s點", slot2, slot3, slot4)
	},
	[slot0.FindTimeType.YMD_W_HM] = {
		string.format("%s/%s/%s (%s) %s:%s", slot1, slot2, slot3, slot7, slot4, slot5),
		string.format("%s/%s/%s （%s） %s:%s", slot1, slot2, slot3, slot7, slot4, slot5),
		string.format("%s年%s月%s日 (%s) %s:%s", slot1, slot2, slot3, slot7, slot4, slot5),
		string.format("%s年%s月%s日 （%s） %s:%s", slot1, slot2, slot3, slot7, slot4, slot5)
	}
}
slot0.WeekDayToChar = {
	"月",
	"火",
	"水",
	"木",
	"金",
	"土",
	"日"
}
slot0.IMGMaxWidth = 1240

return slot0

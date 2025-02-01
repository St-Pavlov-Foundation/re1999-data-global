module("modules.logic.room.define.RoomRecordEnum", package.seeall)

slot0 = _M
slot0.View = {
	HandBook = 3,
	Task = 1,
	Log = 2
}
slot0.LogType = {
	Normal = 2,
	Custom = 3,
	Time = 4,
	Speical = 1
}
slot0.Dir = {
	Left = 1,
	Right = 2
}
slot0.Relation = {
	Close = 1,
	Both = 3,
	Estrange = 2
}
slot0.AnimName = {
	Log2Task = "2to1",
	HandBook2Log = "3to2",
	HandBook2Task = "3to1",
	Task2Log = "1to2",
	Log2HandBook = "2to3",
	Task2HandBook = "1to3"
}
slot0.AnimTime = 0.16

return slot0

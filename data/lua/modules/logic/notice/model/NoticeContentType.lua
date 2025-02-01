module("modules.logic.notice.model.NoticeContentType", package.seeall)

slot0 = _M
slot0.TxtTopTitle = 1
slot0.TxtContent = 3
slot0.ImgInner = 4
slot0.ImgTitle = 5
slot0.Align = {
	Left = 1,
	Center = 2,
	Right = 3
}
slot0.LinkType = {
	InnerLink = 1,
	OutLink = 2,
	DeepLink = 3,
	Time = 4
}
slot0.Anchor = {
	LeftAnchor = Vector2.New(0, 0),
	CenterAnchor = Vector2.New(0.5, 0),
	RightAnchor = Vector2.New(1, 0)
}

return slot0

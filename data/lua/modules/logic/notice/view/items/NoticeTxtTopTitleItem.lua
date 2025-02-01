module("modules.logic.notice.view.items.NoticeTxtTopTitleItem", package.seeall)

slot0 = class("NoticeTxtTopTitleItem", NoticeContentBaseItem)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0.goTopTitle = gohelper.findChild(slot1, "#go_topTitle")
	slot0.txtTopTitle = gohelper.findChildText(slot1, "#go_topTitle/#txt_title")
end

function slot0.show(slot0)
	gohelper.setActive(slot0.goTopTitle, true)

	slot0.txtTopTitle.text = "<line-indent=-5>" .. slot0.mo.content
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.goTopTitle, false)
end

return slot0

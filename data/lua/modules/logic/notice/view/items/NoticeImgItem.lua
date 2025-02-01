module("modules.logic.notice.view.items.NoticeImgItem", package.seeall)

slot0 = class("NoticeImgItem", NoticeContentBaseItem)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0.btnImg = gohelper.findChildButtonWithAudio(slot1, "#img_inner")
	slot0.goImg = slot0.btnImg.gameObject
	slot0.trImg = slot0.goImg:GetComponent(gohelper.Type_RectTransform)
end

function slot0.addEventListeners(slot0)
	slot0.btnImg:AddClickListener(slot0.onClickImg, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnImg:RemoveClickListener()
end

function slot0.onClickImg(slot0)
	if not string.nilorempty(slot0.mo.link) then
		if ViewMgr.instance:getContainer(ViewName.NoticeView) then
			slot1:trackNoticeJump(slot0.mo)
		end

		slot0:jump(slot0.mo.linkType, slot0.mo.link, slot0.mo.link1, slot0.mo.useWebView == 1, slot0.mo.recordUser == 1)
		StatController.instance:track(StatEnum.EventName.ClickNoticeImage, {
			[StatEnum.EventProperties.NoticeType] = NoticeContentListModel.instance:getCurSelectNoticeTypeStr(),
			[StatEnum.EventProperties.NoticeTitle] = NoticeContentListModel.instance:getCurSelectNoticeTitle()
		})
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0.goImg, true)

	if MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goImg, NoticeImage):load(slot0.mo.content) then
		if not slot1.width then
			slot1.width, slot1.height = NoticeModel.instance:getSpriteCacheDefaultSize(SLFramework.FileHelper.GetFileName(string.gsub(slot2, "?.*", ""), true))
		end

		recthelper.setSize(slot0.trImg, slot1.width, slot1.height)
	else
		recthelper.setSize(slot0.trImg, NoticeEnum.IMGDefaultWidth, NoticeEnum.IMGDefaultHeight)
	end

	if slot1.align == NoticeContentType.Align.Left then
		slot0.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		slot0.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(slot0.trImg, slot1.width / 2, 0)
	elseif slot1.align == NoticeContentType.Align.Center then
		slot0.trImg.anchorMin = NoticeContentType.Anchor.CenterAnchor
		slot0.trImg.anchorMax = NoticeContentType.Anchor.CenterAnchor

		recthelper.setAnchor(slot0.trImg, 0, 0)
	elseif slot1.align == NoticeContentType.Align.Right then
		slot0.trImg.anchorMin = NoticeContentType.Anchor.RightAnchor
		slot0.trImg.anchorMax = NoticeContentType.Anchor.RightAnchor

		recthelper.setAnchor(slot0.trImg, -slot1.width / 2, 0)
	else
		slot0.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		slot0.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(slot0.trImg, slot1.width / 2, 0)
	end
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.goImg, false)
end

return slot0

module("modules.logic.notice.view.items.NoticeImgItem", package.seeall)

local var_0_0 = class("NoticeImgItem", NoticeContentBaseItem)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.btnImg = gohelper.findChildButtonWithAudio(arg_1_1, "#img_inner")
	arg_1_0.goImg = arg_1_0.btnImg.gameObject
	arg_1_0.trImg = arg_1_0.goImg:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnImg:AddClickListener(arg_2_0.onClickImg, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnImg:RemoveClickListener()
end

function var_0_0.onClickImg(arg_4_0)
	if not string.nilorempty(arg_4_0.mo.link) then
		local var_4_0 = ViewMgr.instance:getContainer(ViewName.NoticeView)

		if var_4_0 then
			var_4_0:trackNoticeJump(arg_4_0.mo)
		end

		arg_4_0:jump(arg_4_0.mo.linkType, arg_4_0.mo.link, arg_4_0.mo.link1, arg_4_0.mo.useWebView == 1, arg_4_0.mo.recordUser == 1)
		StatController.instance:track(StatEnum.EventName.ClickNoticeImage, {
			[StatEnum.EventProperties.NoticeType] = NoticeContentListModel.instance:getCurSelectNoticeTypeStr(),
			[StatEnum.EventProperties.NoticeTitle] = NoticeContentListModel.instance:getCurSelectNoticeTitle()
		})
	end
end

function var_0_0.show(arg_5_0)
	gohelper.setActive(arg_5_0.goImg, true)

	local var_5_0 = arg_5_0.mo
	local var_5_1 = var_5_0.content

	if MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0.goImg, NoticeImage):load(var_5_1) then
		if not var_5_0.width then
			var_5_0.width, var_5_0.height = NoticeModel.instance:getSpriteCacheDefaultSize(SLFramework.FileHelper.GetFileName(string.gsub(var_5_1, "?.*", ""), true))
		end

		recthelper.setSize(arg_5_0.trImg, var_5_0.width, var_5_0.height)
	else
		recthelper.setSize(arg_5_0.trImg, NoticeEnum.IMGDefaultWidth, NoticeEnum.IMGDefaultHeight)
	end

	if var_5_0.align == NoticeContentType.Align.Left then
		arg_5_0.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		arg_5_0.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(arg_5_0.trImg, var_5_0.width / 2, 0)
	elseif var_5_0.align == NoticeContentType.Align.Center then
		arg_5_0.trImg.anchorMin = NoticeContentType.Anchor.CenterAnchor
		arg_5_0.trImg.anchorMax = NoticeContentType.Anchor.CenterAnchor

		recthelper.setAnchor(arg_5_0.trImg, 0, 0)
	elseif var_5_0.align == NoticeContentType.Align.Right then
		arg_5_0.trImg.anchorMin = NoticeContentType.Anchor.RightAnchor
		arg_5_0.trImg.anchorMax = NoticeContentType.Anchor.RightAnchor

		recthelper.setAnchor(arg_5_0.trImg, -var_5_0.width / 2, 0)
	else
		arg_5_0.trImg.anchorMin = NoticeContentType.Anchor.LeftAnchor
		arg_5_0.trImg.anchorMax = NoticeContentType.Anchor.LeftAnchor

		recthelper.setAnchor(arg_5_0.trImg, var_5_0.width / 2, 0)
	end
end

function var_0_0.hide(arg_6_0)
	gohelper.setActive(arg_6_0.goImg, false)
end

return var_0_0

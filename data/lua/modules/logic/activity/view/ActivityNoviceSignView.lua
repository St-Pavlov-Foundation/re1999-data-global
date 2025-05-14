module("modules.logic.activity.view.ActivityNoviceSignView", package.seeall)

local var_0_0 = class("ActivityNoviceSignView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageframebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "character/image_frame")
	arg_1_0._simagecharacter = gohelper.findChildSingleImage(arg_1_0.viewGO, "character/image_character")
	arg_1_0._godaylist = gohelper.findChild(arg_1_0.viewGO, "#go_daylist")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_daylist/#scroll_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0._refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_3_0._refresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtdesc = gohelper.findChildText(arg_4_0.viewGO, "activitydesc/tips/#txt_desc")
	arg_4_0._txtreward = gohelper.findChildText(arg_4_0.viewGO, "activitydesc/tips/#txt_reward")
	arg_4_0._gostarlist = gohelper.findChild(arg_4_0.viewGO, "activitydesc/tips/#go_starlist")
	arg_4_0._gostaricon = gohelper.findChild(arg_4_0.viewGO, "activitydesc/tips/#go_starlist/#go_staricon")
	arg_4_0._actId = ActivityEnum.Activity.NoviceSign

	Activity101Rpc.instance:sendGet101InfosRequest(arg_4_0._actId)
	arg_4_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_bg"))
	arg_4_0._simageframebg:LoadImage(ResUrl.getActivityBg("eightday/img_lihui_deco_fire"))
	arg_4_0._simagecharacter:LoadImage(ResUrl.getActivityBg("eightday/char_008"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
end

function var_0_0._refresh(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, 8 do
		local var_7_1 = {
			data = ActivityConfig.instance:getNorSignActivityCo(arg_7_0._actId, iter_7_0)
		}

		table.insert(var_7_0, var_7_1)
	end

	ActivityNoviceSignItemListModel.instance:setDayList(var_7_0)

	local var_7_2 = ActivityConfig.instance:getActivityCo(arg_7_0._actId)
	local var_7_3 = string.splitToNumber(var_7_0[8].data.bonus, "#")
	local var_7_4, var_7_5 = ItemModel.instance:getItemConfigAndIcon(var_7_3[1], var_7_3[2])

	if var_7_3[1] == MaterialEnum.MaterialType.Hero then
		if GameConfig:GetCurLangType() == LangSettings.jp then
			gohelper.setActive(arg_7_0._gostarlist, false)

			local var_7_6 = var_7_2.actDesc
			local var_7_7 = string.rep("<sprite=0>", 5)
			local var_7_8 = string.format("%s<color=#c66030>%s</color>", luaLang("activitynovicesign_character"), var_7_4.name)

			arg_7_0._txtdesc.text = string.format(var_7_6, var_7_7 .. var_7_8)
			arg_7_0._txtreward.text = ""
		else
			local var_7_9 = GameConfig:GetCurLangType() == LangSettings.zh and "%s<color=#c66030>%s</color>。" or "%s<color=#c66030> %s</color>."

			gohelper.setActive(arg_7_0._gostarlist, true)

			arg_7_0._txtdesc.text = string.format("%s", var_7_2.actDesc)
			arg_7_0._txtreward.text = string.format(var_7_9, luaLang("activitynovicesign_character"), var_7_4.name)

			if not arg_7_0._hasCreateStar then
				for iter_7_1 = 1, 4 do
					gohelper.cloneInPlace(arg_7_0._gostaricon, "star" .. iter_7_1)
				end

				arg_7_0._hasCreateStar = true
			end
		end
	else
		gohelper.setActive(arg_7_0._gostarlist, false)

		arg_7_0._txtdesc.text = string.format("%s", var_7_2.actDesc)
		arg_7_0._txtreward.text = string.format("<color=#c66030>%s</color>", var_7_4.name)
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageframebg:UnLoadImage()
	arg_9_0._simagecharacter:UnLoadImage()
end

return var_0_0

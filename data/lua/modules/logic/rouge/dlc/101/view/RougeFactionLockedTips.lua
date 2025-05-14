module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTips", package.seeall)

local var_0_0 = class("RougeFactionLockedTips", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrolltips = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tips")
	arg_1_0._imageskillicon = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/top/#image_skillicon")
	arg_1_0._godesccontainer = gohelper.findChild(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	arg_1_0._txtdecitem = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	arg_1_0._btncostunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock")
	arg_1_0._txtunlocknum = gohelper.findChildText(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_tips/Viewport/Content/#btn_costunlock/#txt_unlocknum/#image_icon")
	arg_1_0._goRightTop = gohelper.findChild(arg_1_0.viewGO, "#go_RightTop")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#go_RightTop/point/#image_point")
	arg_1_0._txtpoint = gohelper.findChildText(arg_1_0.viewGO, "#go_RightTop/point/#txt_point")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_RightTop/point/#btn_click")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_RightTop/tips")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#go_RightTop/tips/#txt_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncostunlock:AddClickListener(arg_2_0._btncostunlockOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncostunlock:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncostunlockOnClick(arg_5_0)
	if RougeDLCModel101.instance:getTotalEmblemCount() >= arg_5_0._unlockEmblem then
		AudioMgr.instance:trigger(AudioEnum.UI.UnlockRougeSkill)

		local var_5_0 = RougeOutsideModel.instance:season()

		RougeRpc.instance:sendRougeUnlockSkillRequest(var_5_0, arg_5_0._unlockSkillId, function(arg_6_0, arg_6_1)
			if arg_6_1 ~= 0 then
				return
			end

			RougeOutsideModel.instance:getRougeGameRecord():updateSkillUnlockInfo(arg_5_0._skillType, arg_5_0._unlockSkillId)
			RougeDLCModel101.instance:getLimiterMo():updateTotalEmblemCount(-arg_5_0._unlockEmblem)
			RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
			RougeController.instance:dispatchEvent(RougeEvent.UpdateUnlockSkill, arg_5_0._skillType, arg_5_0._unlockSkillId)
			arg_5_0:closeThis()
		end)
	else
		GameFacade.showToast(ToastEnum.LackEmblem)
	end
end

function var_0_0._btnclickOnClick(arg_7_0)
	arg_7_0._isTipVisible = not arg_7_0._isTipVisible

	gohelper.setActive(arg_7_0._gotips, arg_7_0._isTipVisible)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, arg_8_0._onUpdateEmblem, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshSkillInfo()
	arg_10_0:_onUpdateEmblem()
end

local var_0_1 = "#D5D1C8"
local var_0_2 = "#BF2E11"

function var_0_0._refreshSkillInfo(arg_11_0)
	arg_11_0._unlockSkillId = arg_11_0.viewParam and arg_11_0.viewParam.skillId

	local var_11_0 = RougeDLCConfig101.instance:getUnlockSkills(arg_11_0._unlockSkillId)

	arg_11_0._skillType = var_11_0.type
	arg_11_0._unlockEmblem = var_11_0 and var_11_0.unlockEmblem or 0

	local var_11_1 = RougeDLCModel101.instance:getTotalEmblemCount() >= arg_11_0._unlockEmblem and var_0_1 or var_0_2

	arg_11_0._txtunlocknum.text = string.format("<%s>-%s</color>", var_11_1, arg_11_0._unlockEmblem)

	local var_11_2 = RougeOutsideModel.instance:config():getSkillCo(var_11_0.type, var_11_0.skillId)
	local var_11_3 = {}

	if not string.nilorempty(var_11_2.desc) then
		var_11_3 = string.split(var_11_2.desc, "#")
	end

	gohelper.CreateObjList(arg_11_0, arg_11_0.refreshDesc, var_11_3, arg_11_0._godesccontainer, arg_11_0._txtdecitem.gameObject)
	UISpriteSetMgr.instance:setRouge2Sprite(arg_11_0._imageskillicon, var_11_2.icon)
end

function var_0_0.refreshDesc(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	gohelper.onceAddComponent(arg_12_1, gohelper.Type_TextMesh).text = arg_12_2
end

function var_0_0._onUpdateEmblem(arg_13_0)
	local var_13_0 = lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount]
	local var_13_1 = var_13_0 and var_13_0.value or 0
	local var_13_2 = RougeDLCModel101.instance:getTotalEmblemCount()
	local var_13_3 = {
		var_13_2,
		var_13_1
	}

	arg_13_0._txtpoint.text = RougeDLCModel101.instance:getTotalEmblemCount()
	arg_13_0._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), var_13_3)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0

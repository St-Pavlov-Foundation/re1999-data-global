module("modules.logic.tips.view.SkillTipView", package.seeall)

local var_0_0 = class("SkillTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonewskilltip = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip")
	arg_1_0._goassassinbg = gohelper.findChild(arg_1_0.viewGO, "#go_newskilltip/skillbgassassin")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_1_0._btnupgradeShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_newskilltip/#btn_upgradeShow")
	arg_1_0._goScrollSkill = gohelper.findChild(arg_1_0.viewGO, "#scroll_skill")
	arg_1_0._goContentSkill = gohelper.findChild(arg_1_0.viewGO, "#scroll_skill/Viewport/Content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffContainer, false)
	gohelper.setActive(arg_4_0._btnupgradeShow.gameObject, false)

	arg_4_0._viewInitialized = true
end

function var_0_0.showInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._viewInitialized then
		return
	end

	arg_5_0.entityMo = FightDataHelper.entityMgr:getById(arg_5_3)
	arg_5_0.monsterName = FightConfig.instance:getEntityName(arg_5_3)
	arg_5_0.entitySkillIndex = arg_5_1.skillIndex

	if string.nilorempty(arg_5_0.monsterName) then
		logError("SkillTipView monsterName 为 nil, entityId : " .. tostring(arg_5_3))

		arg_5_0.monsterName = ""
	end

	arg_5_0._upgradeSelectShow = false

	arg_5_0:initInfo(arg_5_1, arg_5_2, arg_5_3)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function var_0_0.hideInfo(arg_6_0)
	if not arg_6_0._viewInitialized then
		return
	end

	gohelper.setActive(arg_6_0._goScrollSkill, false)
	gohelper.setActive(arg_6_0._gonewskilltip, false)

	if arg_6_0._normalSkillLevelComp then
		arg_6_0._normalSkillLevelComp.upgraded = false
		arg_6_0._normalSkillLevelComp._upgradeSelectShow = false
	end

	arg_6_0._curSkillLevel = nil
end

function var_0_0._getLevelComp(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._skillTiplLevelComps[arg_7_1]

	if not var_7_0 then
		local var_7_1 = gohelper.clone(arg_7_0._gonewskilltip, arg_7_0._goContentSkill)

		var_7_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, SkillTipLevelComp, arg_7_0)
		arg_7_0._skillTiplLevelComps[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0._refreshLevelComps(arg_8_0)
	return
end

function var_0_0.initInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._skillTiplLevelComps then
		arg_9_0._skillTiplLevelComps = arg_9_0:getUserDataTb_()
	end

	local var_9_0 = arg_9_0.viewParam or {}

	var_9_0.viewName = arg_9_0.viewName
	var_9_0.entityId = arg_9_3

	if arg_9_0.viewName == ViewName.FightFocusView then
		var_9_0.monsterName = arg_9_0.monsterName
	end

	local var_9_1 = var_9_0.skillIdList

	if arg_9_1 then
		var_9_1 = arg_9_1.skillIdList
		var_9_0.super = arg_9_1.super
		var_9_0.isCharacter = arg_9_2
		var_9_0.entitySkillIndex = arg_9_1.skillIndex
	end

	local var_9_2 = SkillConfig.instance:getFightCardChoice(var_9_1)

	if var_9_2 then
		local var_9_3 = #var_9_2

		for iter_9_0 = 1, var_9_3 do
			var_9_0.skillIdList = var_9_2[iter_9_0]

			arg_9_0:_getLevelComp(iter_9_0):initInfo(var_9_0)
		end

		if arg_9_0.viewName == ViewName.FightFocusView then
			local var_9_4 = arg_9_0.viewGO.transform.parent and arg_9_0.viewGO.transform.parent.transform.offsetMin

			if var_9_4 and var_9_4.x ~= 0 then
				arg_9_0._goScrollSkill.transform.offsetMin = Vector2(-var_9_4.x, var_9_4.y)
			end
		end

		for iter_9_1 = var_9_3 + 1, #arg_9_0._skillTiplLevelComps do
			arg_9_0._skillTiplLevelComps[iter_9_1]:hideInfo()
		end

		gohelper.setActive(arg_9_0._goScrollSkill, true)
		gohelper.setActive(arg_9_0._gonewskilltip, false)
	else
		if not arg_9_0._normalSkillLevelComp then
			arg_9_0._normalSkillLevelComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_0._gonewskilltip, SkillTipLevelComp, arg_9_0)
		end

		var_9_0.skillIdList = var_9_1

		arg_9_0._normalSkillLevelComp:initInfo(var_9_0)
		arg_9_0:_setSkillTipPos()
		gohelper.setActive(arg_9_0._goScrollSkill, false)
		gohelper.setActive(arg_9_0._gonewskilltip, true)
	end

	gohelper.setActive(arg_9_0._goassassinbg, arg_9_0.viewParam and arg_9_0.viewParam.showAssassinBg)
	arg_9_0:_setViewAnchorPos()
end

function var_0_0._setViewAnchorPos(arg_10_0)
	local var_10_0 = arg_10_0.viewGO.transform
	local var_10_1 = arg_10_0.viewParam and arg_10_0.viewParam.anchorX

	if var_10_1 then
		recthelper.setAnchorX(var_10_0, var_10_1)
	end

	local var_10_2 = arg_10_0.viewParam and arg_10_0.viewParam.anchorY

	if var_10_2 then
		recthelper.setAnchorY(var_10_0, var_10_2)
	end
end

function var_0_0._setSkillTipPos(arg_11_0)
	local var_11_0 = arg_11_0._goBuffItem.transform

	if arg_11_0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(arg_11_0._gonewskilltip.transform, 270, -24.3)
			recthelper.setAnchorX(var_11_0, -38)
		else
			transformhelper.setLocalPosXY(arg_11_0._gonewskilltip.transform, 185.12, 49.85)
			recthelper.setAnchorX(var_11_0, -120)
		end
	else
		transformhelper.setLocalPosXY(arg_11_0._gonewskilltip.transform, 0.69, -0.54)
		recthelper.setAnchorX(var_11_0, -304)
	end
end

function var_0_0.onClickSkillItem(arg_12_0, arg_12_1)
	if arg_12_0._curSkillLevel and arg_12_1 == arg_12_0._curSkillLevel then
		return
	end

	arg_12_0._curSkillLevel = arg_12_1

	if arg_12_0._normalSkillLevelComp then
		arg_12_0._normalSkillLevelComp:_refreshSkill(arg_12_1)
	end

	if arg_12_0._skillTiplLevelComps and #arg_12_0._skillTiplLevelComps > 0 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._skillTiplLevelComps) do
			iter_12_1:_refreshSkill(arg_12_1)
		end
	end
end

function var_0_0.onUpdateParam(arg_13_0)
	if arg_13_0.viewName ~= ViewName.FightFocusView then
		arg_13_0:initInfo()
	end
end

function var_0_0.onOpen(arg_14_0)
	if arg_14_0.viewName ~= ViewName.FightFocusView then
		arg_14_0:initInfo()
	else
		arg_14_0:hideInfo()
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._skillTiplLevelComps then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._skillTiplLevelComps) do
			iter_16_1:onDestroyView()
		end
	end

	if arg_16_0._normalSkillLevelComp then
		arg_16_0._normalSkillLevelComp:onDestroyView()
	end
end

return var_0_0

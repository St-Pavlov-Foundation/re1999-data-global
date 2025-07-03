module("modules.logic.tower.view.assistboss.TowerAssistBossTalentItem", package.seeall)

local var_0_0 = class("TowerAssistBossTalentItem", ListScrollCellExtend)
local var_0_1 = 0
local var_0_2 = -385

function var_0_0.onInitView(arg_1_0)
	arg_1_0.transform = arg_1_0.viewGO.transform
	arg_1_0.anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.imgTalent = gohelper.findChildImage(arg_1_0.viewGO, "btn/image_BG")
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "btn/goSelect")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn")
	arg_1_0.bigEff = gohelper.findChild(arg_1_0.viewGO, "btn/btneff_big")
	arg_1_0.smallEff = gohelper.findChild(arg_1_0.viewGO, "btn/btneff_small")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClick)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onBtnClick(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	TowerAssistBossTalentListModel.instance:setSelectTalent(arg_5_0._mo.id)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, true)

	arg_6_0._mo = arg_6_1
	arg_6_0.isBigNode = arg_6_0._mo.config.isBigNode == 1

	arg_6_0:refreshNode()
	arg_6_0:refreshState()
	arg_6_0:refreshSelect()
end

function var_0_0.refreshNode(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	TowerConfig.instance:setTalentImg(arg_7_0.imgTalent, arg_7_0._mo.config, true)

	local var_7_0, var_7_1 = arg_7_0:getNodePos()

	recthelper.setAnchor(arg_7_0.transform, var_7_0, var_7_1)

	local var_7_2 = arg_7_0.isBigNode and 1.2 or 0.6

	transformhelper.setLocalScale(arg_7_0.goSelect.transform, var_7_2, var_7_2, 1)

	local var_7_3 = 1

	if arg_7_0.isBigNode and not arg_7_0._mo:isRootNode() then
		var_7_3 = 0.7
	end

	transformhelper.setLocalScale(arg_7_0.transform, var_7_3, var_7_3, 1)
end

function var_0_0.getWidth(arg_8_0)
	if not arg_8_0._mo then
		return 0
	end

	return arg_8_0.isBigNode and 72 or 24
end

function var_0_0.getLocalPos(arg_9_0)
	local var_9_0, var_9_1 = recthelper.getAnchor(arg_9_0.transform)
	local var_9_2 = var_9_0 - var_0_1
	local var_9_3 = var_9_1 - var_0_2

	return var_9_2, var_9_3
end

function var_0_0.refreshState(arg_10_0)
	if not arg_10_0._mo then
		return
	end

	local var_10_0 = arg_10_0._mo
	local var_10_1 = var_10_0:isActiveTalent()
	local var_10_2 = var_10_0:isActiveGroup()
	local var_10_3 = var_10_0:isParentActive()
	local var_10_4 = var_10_0:isSelectedSystemTalentPlan()

	if not var_10_1 and not var_10_2 and var_10_3 and not var_10_4 then
		if arg_10_0.isGray then
			arg_10_0.anim:Play("tocanlight")
		else
			arg_10_0.anim:Play("canlight")
		end

		arg_10_0.isGray = false
	elseif var_10_1 then
		if not arg_10_0.isLighted then
			arg_10_0.anim:Play("lighted")
		end

		arg_10_0.isGray = false
	else
		arg_10_0.anim:Play("gray")

		arg_10_0.isGray = true
	end

	arg_10_0.isLighted = var_10_1

	gohelper.setActive(arg_10_0.bigEff, var_10_1 and arg_10_0.isBigNode)
	gohelper.setActive(arg_10_0.smallEff, var_10_1 and not arg_10_0.isBigNode)
end

function var_0_0.refreshSelect(arg_11_0)
	if not arg_11_0._mo then
		return
	end

	local var_11_0 = TowerAssistBossTalentListModel.instance:isSelectTalent(arg_11_0._mo.id)

	gohelper.setActive(arg_11_0.goSelect, var_11_0)
end

function var_0_0.getNodePos(arg_12_0)
	local var_12_0 = arg_12_0._mo.config.position
	local var_12_1 = string.splitToNumber(var_12_0, "#") or {}
	local var_12_2 = var_12_1[1] or 0
	local var_12_3 = var_12_1[2] or 0
	local var_12_4 = math.rad(var_12_3)
	local var_12_5 = var_12_2 * math.cos(var_12_4) + var_0_1
	local var_12_6 = var_12_2 * math.sin(var_12_4) + var_0_2

	return var_12_5, var_12_6
end

function var_0_0.playLightingAnim(arg_13_0)
	arg_13_0.isLighted = true

	arg_13_0.anim:Play("lighting")
	gohelper.setActive(arg_13_0.bigEff, arg_13_0.isBigNode)
	gohelper.setActive(arg_13_0.smallEff, not arg_13_0.isBigNode)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

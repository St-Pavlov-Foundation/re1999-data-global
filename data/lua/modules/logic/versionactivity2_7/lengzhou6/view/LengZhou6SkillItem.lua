module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6SkillItem", package.seeall)

local var_0_0 = class("LengZhou6SkillItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSkillEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_SkillEmpty")
	arg_1_0._goHaveSkill = gohelper.findChild(arg_1_0.viewGO, "#go_HaveSkill")
	arg_1_0._imageSkillIIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_HaveSkill/SkillIconMask/#image_SkillIIcon")
	arg_1_0._imagecd = gohelper.findChildImage(arg_1_0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd")
	arg_1_0._txtcd = gohelper.findChildText(arg_1_0.viewGO, "#go_HaveSkill/SkillIconMask/#image_cd/#txt_cd")
	arg_1_0._imageSkillSmallIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_HaveSkill/#image_SkillSmallIcon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_HaveSkill/#image_SkillSmallIcon/#txt_num")
	arg_1_0._goSkillNeedChange = gohelper.findChild(arg_1_0.viewGO, "#go_SkillNeedChange")
	arg_1_0._imagechange = gohelper.findChildImage(arg_1_0.viewGO, "#go_SkillNeedChange/#image_change")

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

local var_0_1 = 0.5
local var_0_2 = 99999

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._skillClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._imageSkillIIcon.gameObject)

	arg_4_0._skillClick:AddClickListener(arg_4_0._click, arg_4_0)

	arg_4_0._skillSelectClick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._imagechange.gameObject)

	arg_4_0._skillSelectClick:AddClickListener(arg_4_0._selectClick, arg_4_0)

	arg_4_0._goSelect = gohelper.findChild(arg_4_0.viewGO, "#go_HaveSkill/SkillIconMask/vx_select")
	arg_4_0._goComing = gohelper.findChild(arg_4_0.viewGO, "#go_HaveSkill/SkillIconMask/vx_coming")
	arg_4_0._goCanuse = gohelper.findChild(arg_4_0.viewGO, "#go_HaveSkill/SkillIconMask/vx_canuse")
	arg_4_0._goCanchange = gohelper.findChild(arg_4_0.viewGO, "#go_SkillNeedChange/vx_canchange")
end

function var_0_0._click(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_5_0._skill == nil then
		return
	end

	if not LengZhou6EliminateController.instance:getPerformIsFinish() then
		return
	end

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnClickSkill, arg_5_0._skill)
end

function var_0_0._selectClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectSkill then
		LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.ShowSelectView, arg_6_0._index)
	end
end

function var_0_0.initSkill(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._skill = arg_7_1
	arg_7_0._configId = nil
	arg_7_0._index = arg_7_2 or 1

	if arg_7_0._skill ~= nil then
		arg_7_0._configId = arg_7_0._skill:getConfig().id
		arg_7_0._skillId = arg_7_0._skill._id
	end

	gohelper.setActive(arg_7_0._goComing, false)
	gohelper.setActive(arg_7_0._goSelect, false)
	gohelper.setActive(arg_7_0._goCanuse, false)
	gohelper.setActive(arg_7_0._goCanchange, false)
end

function var_0_0.initSkillConfigId(arg_8_0, arg_8_1)
	arg_8_0._configId = arg_8_1
end

function var_0_0.selectIsFinish(arg_9_0, arg_9_1)
	arg_9_0._selectIsFinish = arg_9_1
end

function var_0_0.initCamp(arg_10_0, arg_10_1)
	arg_10_0._camp = arg_10_1
end

function var_0_0.refreshState(arg_11_0)
	local var_11_0 = arg_11_0._skillId == nil
	local var_11_1 = arg_11_0._configId == nil

	if not var_11_1 then
		arg_11_0:initInfo()
	end

	if not var_11_0 then
		arg_11_0:updateInfo()
	end

	gohelper.setActive(arg_11_0._goSkillEmpty, var_11_1)
	gohelper.setActive(arg_11_0._goHaveSkill, not var_11_1)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		local var_11_2 = LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectFinish
		local var_11_3 = not var_11_2 and arg_11_0._camp == LengZhou6Enum.entityCamp.player

		gohelper.setActive(arg_11_0._goSkillNeedChange, var_11_3)

		if not var_11_2 then
			gohelper.setActive(arg_11_0._imagecd.gameObject, false)
		end
	else
		gohelper.setActive(arg_11_0._goSkillNeedChange, false)
	end

	arg_11_0:updateCanChangeActive()
end

function var_0_0.useSkill(arg_12_0, arg_12_1)
	if arg_12_0._skillId == arg_12_1 then
		arg_12_0._skillId = nil
		arg_12_0._configId = nil
	end

	arg_12_0:refreshState()
end

function var_0_0.initInfo(arg_13_0)
	local var_13_0 = LengZhou6Config.instance:getEliminateBattleSkill(arg_13_0._configId)

	if var_13_0 == nil then
		return
	end

	local var_13_1 = var_13_0.icon

	if var_13_1 ~= nil then
		local var_13_2 = string.split(var_13_1, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(arg_13_0._imageSkillIIcon, var_13_2[1])

		local var_13_3 = var_13_2[2] ~= nil

		if var_13_3 then
			UISpriteSetMgr.instance:setHisSaBethSprite(arg_13_0._imageSkillSmallIcon, var_13_2[2])
		end

		gohelper.setActive(arg_13_0._imageSkillSmallIcon.gameObject, var_13_3)
	end

	local var_13_4 = var_13_0.effect

	if var_13_4 ~= nil then
		local var_13_5 = string.split(var_13_4, "#")

		if var_13_5[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			local var_13_6 = tonumber(var_13_5[2])

			arg_13_0._txtnum.text = var_13_6
		end

		gohelper.setActive(arg_13_0._txtnum, var_13_5[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end
end

function var_0_0.updateSkillInfo(arg_14_0)
	if arg_14_0._configId == nil then
		return
	end

	if arg_14_0._skill ~= nil and arg_14_0._skill:getEffect()[1] == LengZhou6Enum.SkillEffect.DealsDamage then
		arg_14_0._txtnum.text = arg_14_0._skill:getTotalValue()
	end

	local var_14_0 = LengZhou6Config.instance:getEliminateBattleSkill(arg_14_0._configId)

	if var_14_0 and var_14_0.type ~= LengZhou6Enum.SkillType.active then
		gohelper.setActive(arg_14_0._imagecd.gameObject, false)

		return
	end

	local var_14_1 = arg_14_0._skill and arg_14_0._skill:getCd() or 0
	local var_14_2 = var_14_1 > 0

	gohelper.setActive(arg_14_0._imagecd.gameObject, var_14_2)

	if var_14_2 then
		arg_14_0._txtcd.text = var_14_1
	else
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.PlayerSkillCanUse)
		gohelper.setActive(arg_14_0._goSelect, true)

		if arg_14_0._lastInCd then
			AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
		end
	end

	arg_14_0._lastInCd = var_14_2

	gohelper.setActive(arg_14_0._goCanuse, arg_14_0._selectIsFinish and not var_14_2)
end

function var_0_0._editableAddEvents(arg_15_0)
	return
end

function var_0_0._editableRemoveEvents(arg_16_0)
	return
end

function var_0_0.updateInfo(arg_17_0)
	arg_17_0:updateSkillInfo()
end

function var_0_0.showEnemySkillRound(arg_18_0, arg_18_1)
	if arg_18_0._goComing then
		gohelper.setActive(arg_18_0._goComing, arg_18_1)
	end
end

function var_0_0.updateCanChangeActive(arg_19_0)
	local var_19_0 = true

	if arg_19_0._selectIsFinish then
		var_19_0 = false
	end

	if arg_19_0._configId ~= nil then
		local var_19_1 = LengZhou6Config.instance:getEliminateBattleSkill(arg_19_0._configId)

		if var_19_1 and var_19_1.type == LengZhou6Enum.SkillType.enemyActive then
			var_19_0 = false
		end
	end

	gohelper.setActive(arg_19_0._goCanchange, var_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._skillClick ~= nil then
		arg_20_0._skillClick:RemoveClickListener()

		arg_20_0._skillClick = nil
	end

	if arg_20_0._skillSelectClick then
		arg_20_0._skillSelectClick:RemoveClickListener()

		arg_20_0._skillSelectClick = nil
	end
end

return var_0_0

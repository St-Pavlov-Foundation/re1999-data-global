module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectView", package.seeall)

local var_0_0 = class("EliminateEffectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")
	arg_1_0._godamages = gohelper.findChild(arg_1_0.viewGO, "#go_damages")
	arg_1_0._gohpFlys = gohelper.findChild(arg_1_0.viewGO, "#go_hpFlys")
	arg_1_0._goflyitem = gohelper.findChild(arg_1_0.viewGO, "#go_flyitem")
	arg_1_0._godamage = gohelper.findChild(arg_1_0.viewGO, "#go_damage")
	arg_1_0._txtdamage = gohelper.findChildText(arg_1_0.viewGO, "#go_damage/#txt_damage")
	arg_1_0._gohpFlyItem1 = gohelper.findChild(arg_1_0.viewGO, "#go_hpFlyItem_1")
	arg_1_0._gohpFlyItem2 = gohelper.findChild(arg_1_0.viewGO, "#go_hpFlyItem_2")
	arg_1_0._gohpFlyItem3 = gohelper.findChild(arg_1_0.viewGO, "#go_hpFlyItem_3")

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

local var_0_1 = GameUtil.parseColor("#AACD70")
local var_0_2 = GameUtil.parseColor("#E0551D")

function var_0_0._editableInitView(arg_4_0)
	if arg_4_0.flyItemPool == nil then
		arg_4_0.flyItemPool = LuaObjPool.New(EliminateEnum.dieEffectCacheCount, function()
			local var_5_0 = gohelper.clone(arg_4_0._goflyitem, arg_4_0._goeffect, "FlyItem")

			gohelper.setActive(var_5_0, false)

			return var_5_0
		end, function(arg_6_0)
			if not gohelper.isNil(arg_6_0) then
				gohelper.setActive(arg_6_0, false)
				gohelper.destroy(arg_6_0)
			end
		end, function(arg_7_0)
			if not gohelper.isNil(arg_7_0) then
				gohelper.setActive(arg_7_0, false)
			end
		end)
	end

	if arg_4_0.damageItemPool == nil then
		arg_4_0.damageItemPool = LuaObjPool.New(EliminateEnum.damageCacheCount, function()
			local var_8_0 = gohelper.clone(arg_4_0._godamage, arg_4_0._godamages, "damageItem")

			gohelper.setActive(var_8_0, false)

			return var_8_0
		end, function(arg_9_0)
			if not gohelper.isNil(arg_9_0) then
				gohelper.setActive(arg_9_0, false)
				gohelper.destroy(arg_9_0)
			end
		end, function(arg_10_0)
			if not gohelper.isNil(arg_10_0) then
				gohelper.setActive(arg_10_0, false)
			end
		end)
	end

	if arg_4_0.characterHpFlyItemPools == nil then
		arg_4_0.characterHpFlyItemPools = {}
	end

	for iter_4_0 = 1, 3 do
		arg_4_0.characterHpFlyItemPools[iter_4_0] = LuaObjPool.New(EliminateEnum.hpDamageCacheCount, function()
			local var_11_0 = gohelper.clone(arg_4_0["_gohpFlyItem" .. iter_4_0], arg_4_0._gohpFlys, "hpFlyItem")

			gohelper.setActive(var_11_0, false)

			return var_11_0
		end, function(arg_12_0)
			if not gohelper.isNil(arg_12_0) then
				gohelper.setActive(arg_12_0, false)
				gohelper.destroy(arg_12_0)
			end
		end, function(arg_13_0)
			if not gohelper.isNil(arg_13_0) then
				gohelper.setActive(arg_13_0, false)
			end
		end)
	end

	arg_4_0._godamagesTr = arg_4_0._godamages.transform
	arg_4_0._goeffectTr = arg_4_0._goeffect.transform
	arg_4_0._gohpFlysTr = arg_4_0._gohpFlys.transform
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, arg_15_0.playResourceFlyEffect, arg_15_0)
	arg_15_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, arg_15_0.playDamageEffect, arg_15_0)
	arg_15_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, arg_15_0.playCharacterHpChange, arg_15_0)
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:removeEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, arg_16_0.playResourceFlyEffect, arg_16_0)
	arg_16_0:removeEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, arg_16_0.playDamageEffect, arg_16_0)
	arg_16_0:removeEventCb(EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, arg_16_0.playCharacterHpChange, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0.flyItemPool then
		arg_17_0.flyItemPool:dispose()

		arg_17_0.flyItemPool = nil
	end
end

local var_0_3 = ZProj.TweenHelper

function var_0_0.playResourceFlyEffect(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = arg_18_0.flyItemPool:getObject()
	local var_18_1 = var_18_0.transform
	local var_18_2, var_18_3 = recthelper.worldPosToAnchorPosXYZ(arg_18_2, arg_18_3, 1, arg_18_0._goeffectTr)

	recthelper.setAnchor(var_18_1, var_18_2, var_18_3)
	gohelper.setActive(var_18_0, true)

	local var_18_4, var_18_5 = recthelper.worldPosToAnchorPosXYZ(arg_18_4, arg_18_5, 1, arg_18_0._goeffectTr)

	var_0_3.DOAnchorPos(var_18_1, var_18_4, var_18_5, EliminateEnum.ResourceFlyTime, arg_18_0.resourceFlyEnd, arg_18_0, {
		item = var_18_0,
		resourceId = arg_18_1
	}, EaseType.OutQuart)
end

function var_0_0.resourceFlyEnd(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.item
	local var_19_1 = arg_19_1.resourceId

	if arg_19_0.flyItemPool and not gohelper.isNil(var_19_0) then
		arg_19_0.flyItemPool:putObject(var_19_0)
	end

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlayFinish, var_19_1)
end

function var_0_0.playDamageEffect(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = arg_20_0.damageItemPool:getObject()
	local var_20_1 = var_20_0.transform
	local var_20_2 = EliminateTeamChessEnum.ChessDamageSize
	local var_20_3 = EliminateTeamChessEnum.teamChessPowerJumpTime

	if EliminateTeamChessEnum.HpDamageType.Character == arg_20_4 then
		var_20_2 = EliminateTeamChessEnum.CharacterHpDamageSize
		var_20_3 = EliminateTeamChessEnum.hpDamageJumpTime
	end

	if EliminateTeamChessEnum.HpDamageType.GrowUpToChess == arg_20_4 then
		var_20_3 = EliminateTeamChessEnum.teamChessGrowUpToChangePowerJumpTime
	end

	local var_20_4 = gohelper.findChildText(var_20_0, "#txt_damage")
	local var_20_5 = arg_20_1 > 0 and "＋%d" or "－%d"

	var_20_4.text = string.format(var_20_5, math.abs(arg_20_1))
	var_20_4.color = arg_20_1 > 0 and var_0_1 or var_0_2
	var_20_4.fontSize = var_20_2

	local var_20_6, var_20_7 = recthelper.worldPosToAnchorPosXYZ(arg_20_2, arg_20_3, 1, arg_20_0._godamagesTr)

	recthelper.setAnchor(var_20_1, var_20_6, var_20_7)
	gohelper.setActive(var_20_0, true)

	local var_20_8 = recthelper.getHeight(var_20_1)

	var_0_3.DOHeight(var_20_1, var_20_8, var_20_3, arg_20_0.playDamageEffectEnd, arg_20_0, var_20_0)
end

function var_0_0.playDamageEffectEnd(arg_21_0, arg_21_1)
	if arg_21_0.damageItemPool and not gohelper.isNil(arg_21_1) then
		arg_21_0.damageItemPool:putObject(arg_21_1)
	end
end

local var_0_4 = ZProj.TweenHelper

function var_0_0.playCharacterHpChange(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	local var_22_0 = EliminateTeamChessModel.instance:calDamageGear(math.abs(arg_22_2))
	local var_22_1 = arg_22_0.characterHpFlyItemPools[var_22_0]

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_fire)

	local var_22_2 = var_22_1:getObject()
	local var_22_3 = var_22_2.transform
	local var_22_4 = arg_22_5 - arg_22_3
	local var_22_5 = arg_22_6 - arg_22_4
	local var_22_6 = math.atan2(var_22_5, var_22_4)
	local var_22_7 = math.deg(var_22_6)

	transformhelper.setEulerAngles(var_22_3, 0, 0, var_22_7 + 180)

	local var_22_8, var_22_9 = recthelper.worldPosToAnchorPosXYZ(arg_22_3, arg_22_4, 1, arg_22_0._gohpFlysTr)

	recthelper.setAnchor(var_22_3, var_22_8, var_22_9)
	gohelper.setActive(var_22_2, true)

	local var_22_10 = recthelper.getHeight(var_22_3)
	local var_22_11, var_22_12 = recthelper.worldPosToAnchorPosXYZ(arg_22_5, arg_22_6, 1, arg_22_0._gohpFlysTr)

	var_0_4.DOAnchorPos(var_22_3, var_22_11, var_22_12, EliminateTeamChessEnum.characterHpDamageFlyTime, nil, nil, nil, EaseType.OutQuart)
	var_0_4.DOHeight(var_22_3, var_22_10, EliminateTeamChessEnum.characterHpDamageFlyTimeTipHpChange, arg_22_0.playCharacterHpChangeFlyEnd, arg_22_0, {
		TeamType = arg_22_1,
		Gear = var_22_0,
		ItemGo = var_22_2,
		diffValue = arg_22_2
	}, EaseType.OutQuart)
end

function var_0_0.playCharacterHpChangeFlyEnd(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.ItemGo
	local var_23_1 = arg_23_1.Gear
	local var_23_2 = arg_23_1.TeamType
	local var_23_3 = arg_23_1.diffValue

	if arg_23_0.characterHpFlyItemPools and arg_23_0.characterHpFlyItemPools[var_23_1] and not gohelper.isNil(var_23_0) then
		arg_23_0.characterHpFlyItemPools[var_23_1]:putObject(var_23_0)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, var_23_2, var_23_3, var_23_1)
end

return var_0_0

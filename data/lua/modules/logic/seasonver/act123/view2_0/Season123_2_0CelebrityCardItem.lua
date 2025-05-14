module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardItem", package.seeall)

local var_0_0 = class("Season123_2_0CelebrityCardItem", LuaCompBase)

var_0_0.AssetPath = "ui/viewres/seasonver/v2a0_act123/season123celebritycarditem.prefab"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0._equipId = arg_1_2

	local var_1_0 = var_0_0.AssetPath

	arg_1_0._showTag = false
	arg_1_0._showNewFlag = arg_1_3 and arg_1_3.showNewFlag
	arg_1_0._showNewFlag2 = arg_1_3 and arg_1_3.showNewFlag2
	arg_1_0._targetFlagUIScale = arg_1_3 and arg_1_3.targetFlagUIScale
	arg_1_0._targetFlagUIPosX = arg_1_3 and arg_1_3.targetFlagUIPosX
	arg_1_0._targetFlagUIPosY = arg_1_3 and arg_1_3.targetFlagUIPosY
	arg_1_0._noClick = arg_1_3 and arg_1_3.noClick
	arg_1_0._gorares = {}
	arg_1_0._gocarditem = gohelper.create2d(arg_1_0.go, "cardItem")
	arg_1_0._resLoader = PrefabInstantiate.Create(arg_1_0._gocarditem)

	arg_1_0._resLoader:startLoad(var_1_0, arg_1_0.handleCardLoaded, arg_1_0)
end

function var_0_0.handleCardLoaded(arg_2_0)
	arg_2_0._cardGo = arg_2_0._resLoader:getInstGO()
	arg_2_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._cardGo, Season123_2_0CelebrityCardEquip)

	if not arg_2_0._noClick then
		arg_2_0._icon:setClickCall(arg_2_0.onBtnClick, arg_2_0)
	end

	arg_2_0:refreshItem()
end

function var_0_0.onBtnClick(arg_3_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, arg_3_0._equipId)
end

function var_0_0.refreshItem(arg_4_0)
	arg_4_0._icon:updateData(arg_4_0._equipId)
	arg_4_0._icon:setShowTag(arg_4_0._showTag)
	arg_4_0._icon:setShowNewFlag(arg_4_0._showNewFlag)
	arg_4_0._icon:setShowNewFlag2(arg_4_0._showNewFlag2)
	arg_4_0._icon:setFlagUIScale(arg_4_0._targetFlagUIScale)
	arg_4_0._icon:setFlagUIPos(arg_4_0._targetFlagUIPosX, arg_4_0._targetFlagUIPosY)
	arg_4_0._icon:setColorDark(arg_4_0._colorDarkEnable)
end

function var_0_0.showTag(arg_5_0, arg_5_1)
	arg_5_0._showTag = arg_5_1

	if arg_5_0._icon then
		arg_5_0._icon:setShowTag(arg_5_1)
	end
end

function var_0_0.showProbability(arg_6_0, arg_6_1)
	arg_6_0._showTag = arg_6_1

	if arg_6_0._icon then
		arg_6_0._icon:setShowProbability(arg_6_1)
	end
end

function var_0_0.showNewFlag(arg_7_0, arg_7_1)
	arg_7_0._showNewFlag = arg_7_1

	if arg_7_0._icon then
		arg_7_0._icon:setShowNewFlag(arg_7_1)
	end
end

function var_0_0.showNewFlag2(arg_8_0, arg_8_1)
	arg_8_0._showNewFlag2 = arg_8_1

	if arg_8_0._icon then
		arg_8_0._icon:setShowNewFlag2(arg_8_1)
	end
end

function var_0_0.reset(arg_9_0, arg_9_1)
	arg_9_0._equipId = arg_9_1

	if arg_9_0._cardGo then
		arg_9_0:refreshItem()
	end
end

function var_0_0.setColorDark(arg_10_0, arg_10_1)
	arg_10_0._colorDarkEnable = arg_10_1

	if arg_10_0._icon then
		arg_10_0._icon:setColorDark(arg_10_1)
	end
end

function var_0_0.destroy(arg_11_0)
	if arg_11_0._icon then
		arg_11_0._icon:disposeUI()

		arg_11_0._icon = nil
	end

	if arg_11_0._gocarditem then
		gohelper.destroy(arg_11_0._gocarditem)

		arg_11_0._gocarditem = nil
	end

	if arg_11_0._cardGo then
		arg_11_0._cardGo = nil
	end

	if arg_11_0._resloader then
		arg_11_0._resloader:dispose()

		arg_11_0._resloader = nil
	end
end

return var_0_0

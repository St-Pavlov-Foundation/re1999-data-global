module("modules.logic.season.view1_6.Season1_6CelebrityCardItem", package.seeall)

local var_0_0 = class("Season1_6CelebrityCardItem", LuaCompBase)

var_0_0.AssetPath = "ui/viewres/v1a6_season/seasoncelebritycarditem.prefab"

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

	arg_1_0._resLoader:startLoad(var_1_0, arg_1_0._cardLoaded, arg_1_0)
end

function var_0_0._cardLoaded(arg_2_0)
	arg_2_0._cardGo = arg_2_0._resLoader:getInstGO()
	arg_2_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._cardGo, Season1_6CelebrityCardEquip)

	if not arg_2_0._noClick then
		arg_2_0._icon:setClickCall(arg_2_0.onBtnClick, arg_2_0)
	end

	arg_2_0:_setItem()
end

function var_0_0.onBtnClick(arg_3_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.EquipCard, arg_3_0._equipId)
end

function var_0_0._setItem(arg_4_0)
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
		arg_9_0:_setItem()
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

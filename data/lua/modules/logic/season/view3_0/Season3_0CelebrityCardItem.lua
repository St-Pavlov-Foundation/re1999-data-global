module("modules.logic.season.view3_0.Season3_0CelebrityCardItem", package.seeall)

local var_0_0 = class("Season3_0CelebrityCardItem", LuaCompBase)

var_0_0.AssetPath = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0._showTag = false
	arg_1_0._showNewFlag = arg_1_3 and arg_1_3.showNewFlag
	arg_1_0._showNewFlag2 = arg_1_3 and arg_1_3.showNewFlag2
	arg_1_0._targetFlagUIScale = arg_1_3 and arg_1_3.targetFlagUIScale
	arg_1_0._targetFlagUIPosX = arg_1_3 and arg_1_3.targetFlagUIPosX
	arg_1_0._targetFlagUIPosY = arg_1_3 and arg_1_3.targetFlagUIPosY
	arg_1_0._noClick = arg_1_3 and arg_1_3.noClick
	arg_1_0._gorares = {}

	arg_1_0:reset(arg_1_2)
end

function var_0_0._cardLoaded(arg_2_0)
	arg_2_0._cardGo = arg_2_0._resLoader:getInstGO()
	arg_2_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._cardGo, Season3_0CelebrityCardEquip)

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

	local var_4_0 = not arg_4_0._equipId or arg_4_0._equipId == 0

	arg_4_0:setVisible(not var_4_0)
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

	if not arg_9_0._gocarditem then
		arg_9_0._gocarditem = gohelper.create2d(arg_9_0.go, "cardItem")
	end

	if not arg_9_0._cardGo and not arg_9_0._resloader then
		arg_9_0._resLoader = PrefabInstantiate.Create(arg_9_0._gocarditem)

		local var_9_0 = var_0_0.AssetPath

		arg_9_0._resLoader:startLoad(var_9_0, arg_9_0._cardLoaded, arg_9_0)
	end

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

function var_0_0.setVisible(arg_11_0, arg_11_1)
	if arg_11_0._isVisible == arg_11_1 then
		return
	end

	arg_11_0._isVisible = arg_11_1

	gohelper.setActive(arg_11_0._gocarditem, arg_11_0._isVisible)
end

function var_0_0.destroy(arg_12_0)
	if arg_12_0._icon then
		arg_12_0._icon:disposeUI()

		arg_12_0._icon = nil
	end

	if arg_12_0._gocarditem then
		gohelper.destroy(arg_12_0._gocarditem)

		arg_12_0._gocarditem = nil
	end

	if arg_12_0._cardGo then
		arg_12_0._cardGo = nil
	end

	if arg_12_0._resloader then
		arg_12_0._resloader:dispose()

		arg_12_0._resloader = nil
	end
end

return var_0_0

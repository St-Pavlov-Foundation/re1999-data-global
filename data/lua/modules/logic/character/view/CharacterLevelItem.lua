module("modules.logic.character.view.CharacterLevelItem", package.seeall)

local var_0_0 = class("CharacterLevelItem", ListScrollCellExtend)
local var_0_1 = 1
local var_0_2 = 0.75
local var_0_3 = 1
local var_0_4 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClickWithDefaultAudio(arg_1_0.viewGO)
	arg_1_0._gocurlv = gohelper.findChild(arg_1_0.viewGO, "#go_curLv")
	arg_1_0._transcurlv = arg_1_0._gocurlv.transform
	arg_1_0._txtcurlv = gohelper.findChildText(arg_1_0.viewGO, "#go_curLv/#txt_curLvNum")
	arg_1_0._txtlvnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_LvNum")
	arg_1_0._translvnum = arg_1_0._txtlvnum.transform
	arg_1_0._txtefflvnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_LvNum/#txt_leveleffect")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_line")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "#go_Max")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, arg_2_0._onPlayLevelUpEff, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_2_0._onChangePreviewLevel, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelScrollChange, arg_2_0._onLevelScrollChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, arg_3_0._onPlayLevelUpEff, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, arg_3_0._onChangePreviewLevel, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelScrollChange, arg_3_0._onLevelScrollChange, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpClickLevel, arg_4_0._mo.level)
end

function var_0_0._onItemChanged(arg_5_0)
	if not arg_5_0._view then
		return
	end

	local var_5_0 = arg_5_0._view.viewContainer

	if var_5_0 and var_5_0:getWaitHeroLevelUpRefresh() then
		return
	end

	arg_5_0:refresh()
end

function var_0_0._onPlayLevelUpEff(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._mo and arg_6_0._mo.heroId

	if not (var_6_0 and HeroModel.instance:getByHeroId(var_6_0)) then
		return
	end

	if arg_6_0._mo.level == arg_6_1 then
		arg_6_0._animator:Play("click", 0, 0)
	end
end

function var_0_0._onChangePreviewLevel(arg_7_0, arg_7_1)
	if not arg_7_0._view then
		return
	end

	local var_7_0 = arg_7_0._view.viewContainer

	if var_7_0 and var_7_0:getWaitHeroLevelUpRefresh() then
		return
	end

	arg_7_0:refreshCurLevelMark()
end

function var_0_0._onLevelScrollChange(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 and math.abs(arg_8_1) or 0

	if arg_8_1 > arg_8_0._itemOffset then
		arg_8_0:refreshScale(-arg_8_1, -arg_8_0._rightBoundary, -arg_8_0._itemOffset)
	else
		arg_8_0:refreshScale(arg_8_1, arg_8_0._leftBoundary, arg_8_0._itemOffset)
	end
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_0._view.viewContainer:getLevelItemWidth()
	local var_10_1 = var_10_0 / 2

	arg_10_0._itemOffset = (arg_10_0._index - 1) * var_10_0
	arg_10_0._rightBoundary = arg_10_0._itemOffset + var_10_1
	arg_10_0._leftBoundary = arg_10_0._itemOffset - var_10_1

	arg_10_0:refresh()

	local var_10_2 = arg_10_0._view.viewContainer.characterLevelUpView:getContentOffset()

	arg_10_0:_onLevelScrollChange(var_10_2)
	arg_10_0._animator:Play("idle", 0, 0)
end

function var_0_0.refresh(arg_11_0)
	local var_11_0 = arg_11_0._mo and HeroConfig.instance:getShowLevel(arg_11_0._mo.level) or ""

	arg_11_0._txtcurlv.text = var_11_0
	arg_11_0._txtlvnum.text = var_11_0
	arg_11_0._txtefflvnum.text = var_11_0

	local var_11_1 = arg_11_0._mo and arg_11_0._mo.heroId
	local var_11_2 = var_11_1 and HeroModel.instance:getByHeroId(var_11_1)

	if not var_11_2 then
		return
	end

	local var_11_3 = true
	local var_11_4 = var_11_2.level
	local var_11_5 = arg_11_0._mo.level
	local var_11_6 = HeroConfig.instance:getLevelUpItems(var_11_1, var_11_4, var_11_5)

	for iter_11_0, iter_11_1 in ipairs(var_11_6) do
		local var_11_7 = tonumber(iter_11_1.type)
		local var_11_8 = tonumber(iter_11_1.id)

		if tonumber(iter_11_1.quantity) > ItemModel.instance:getItemQuantity(var_11_7, var_11_8) then
			var_11_3 = false

			break
		end
	end

	local var_11_9 = var_11_0

	if not var_11_3 then
		var_11_9 = string.format("<color=#793426>%s</color>", var_11_0)
	end

	arg_11_0._txtlvnum.text = var_11_9

	local var_11_10 = CharacterModel.instance:getrankEffects(var_11_1, var_11_2.rank)[1]

	gohelper.setActive(arg_11_0._gomax, var_11_5 == var_11_10)
	arg_11_0:refreshCurLevelMark()
end

function var_0_0.refreshCurLevelMark(arg_12_0)
	local var_12_0 = false
	local var_12_1 = arg_12_0._mo and arg_12_0._mo.heroId
	local var_12_2 = var_12_1 and HeroModel.instance:getByHeroId(var_12_1)

	if var_12_2 then
		local var_12_3 = arg_12_0._mo.level
		local var_12_4 = arg_12_0._view.viewContainer

		if var_12_3 == (var_12_4:getLocalUpLevel() or var_12_2.level) then
			var_12_0 = var_12_4.characterLevelUpView.previewLevel ~= var_12_3
		end
	end

	gohelper.setActive(arg_12_0._gocurlv, var_12_0)
	gohelper.setActive(arg_12_0._goline, not var_12_0)
	gohelper.setActive(arg_12_0._txtlvnum.gameObject, not var_12_0)
end

function var_0_0.refreshScale(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_1 or not arg_13_2 or not arg_13_3 then
		return
	end

	local var_13_0 = GameUtil.remap(arg_13_1, arg_13_2, arg_13_3, var_0_2, var_0_1)

	transformhelper.setLocalScale(arg_13_0._translvnum, var_13_0, var_13_0, var_13_0)

	local var_13_1

	var_13_1.a, var_13_1 = GameUtil.remap(arg_13_1, arg_13_2, arg_13_3, var_0_4, var_0_3), arg_13_0._txtlvnum.color
	arg_13_0._txtlvnum.color = var_13_1
end

return var_0_0

-- chunkname: @modules/logic/currency/view/PowerActChangeViewContainer.lua

module("modules.logic.currency.view.PowerActChangeViewContainer", package.seeall)

local PowerActChangeViewContainer = class("PowerActChangeViewContainer", BaseViewContainer)

function PowerActChangeViewContainer:buildViews()
	local views = {}

	table.insert(views, PowerActChangeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function PowerActChangeViewContainer:buildTabViews(tabContainerId)
	local powerId = self.viewParam and self.viewParam.PowerId or MaterialEnum.PowerId.ActPowerId
	local currencyParam = {
		CurrencyEnum.CurrencyType.Power,
		{
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.PowerPotion,
			id = powerId
		}
	}

	return {
		CurrencyView.New(currencyParam)
	}
end

return PowerActChangeViewContainer

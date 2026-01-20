-- chunkname: @modules/logic/summon/view/SummonResultViewContainer.lua

module("modules.logic.summon.view.SummonResultViewContainer", package.seeall)

local SummonResultViewContainer = class("SummonResultViewContainer", BaseViewContainer)

function SummonResultViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonResultView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function SummonResultViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return self:_buildCurrency()
	end
end

function SummonResultViewContainer:_buildCurrency()
	self._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		{
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item
		}
	}, nil, nil, nil, false)

	return {
		self._currencyView
	}
end

return SummonResultViewContainer

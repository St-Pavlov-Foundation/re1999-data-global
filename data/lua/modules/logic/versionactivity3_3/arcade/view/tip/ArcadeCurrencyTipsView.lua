-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeCurrencyTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeCurrencyTipsView", package.seeall)

local ArcadeCurrencyTipsView = class("ArcadeCurrencyTipsView", ArcadeTipsChildViewBase)

function ArcadeCurrencyTipsView:init(go)
	self.viewGO = go
	self._txtname = gohelper.findChildText(self.viewGO, "root/title/layout/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/title/#image_icon")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeCurrencyTipsView:addEvents()
	return
end

function ArcadeCurrencyTipsView:removeEvents()
	return
end

function ArcadeCurrencyTipsView:onUpdateMO(mo, tipview)
	self._showNewCurrency = self._currencyId ~= mo.currencyId
	self._currencyId = mo.currencyId

	ArcadeCurrencyTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeCurrencyTipsView:refreshView()
	local param = ArcadeEnum.CurrencyParams[self._currencyId]

	if param then
		if not string.nilorempty(param.icon) then
			UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imageicon, param.icon .. "_1")
		end

		local nameConstCo = ArcadeConfig.instance:getArcadeConstCfg(param.nameConst)
		local descConstCo = ArcadeConfig.instance:getArcadeConstCfg(param.descConst)

		self._txtname.text = nameConstCo and nameConstCo.mlvalue or ""
		self._txtdesc.text = descConstCo and descConstCo.mlvalue or ""
	end
end

function ArcadeCurrencyTipsView:isPlayOpenAnim()
	return self._showNewCurrency or self._isChange
end

function ArcadeCurrencyTipsView:onDestroy()
	return
end

return ArcadeCurrencyTipsView

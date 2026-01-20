-- chunkname: @modules/logic/survival/view/SurvivalCurrencyTipView.lua

module("modules.logic.survival.view.SurvivalCurrencyTipView", package.seeall)

local SurvivalCurrencyTipView = class("SurvivalCurrencyTipView", BaseView)

function SurvivalCurrencyTipView:onInitView()
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._rootTrans = gohelper.findChild(self.viewGO, "root").transform
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#txt_dec")
end

function SurvivalCurrencyTipView:addEvents()
	self._click:AddClickListener(self.closeThis, self)
end

function SurvivalCurrencyTipView:removeEvents()
	self._click:RemoveClickListener()
end

function SurvivalCurrencyTipView:onOpen()
	if self.viewParam.arrow == "BL" then
		self._rootTrans.pivot = Vector2(1, 1)
	elseif self.viewParam.arrow == "BR" then
		self._rootTrans.pivot = Vector2(0, 1)
	else
		self._rootTrans.pivot = Vector2(0, 0)
	end

	local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform.parent)

	recthelper.setAnchor(self._rootTrans, anchorPos.x, anchorPos.y)

	if self.viewParam.txt then
		self._txtdesc.text = self.viewParam.txt
	else
		local id = self.viewParam.id
		local itemCo = lua_survival_item.configDict[id]

		self._txtdesc.text = itemCo and itemCo.desc1 or ""
	end
end

return SurvivalCurrencyTipView

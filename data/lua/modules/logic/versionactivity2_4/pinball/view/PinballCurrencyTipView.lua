-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCurrencyTipView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyTipView", package.seeall)

local PinballCurrencyTipView = class("PinballCurrencyTipView", BaseView)

function PinballCurrencyTipView:onInitView()
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._rootTrans = gohelper.findChild(self.viewGO, "root").transform
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#txt_dec")
end

function PinballCurrencyTipView:addEvents()
	self._click:AddClickListener(self.closeThis, self)
end

function PinballCurrencyTipView:removeEvents()
	self._click:RemoveClickListener()
end

function PinballCurrencyTipView:onOpen()
	if self.viewParam.arrow == "BL" then
		self._rootTrans.pivot = Vector2(1, 1)
	else
		self._rootTrans.pivot = Vector2(0, 0)
	end

	local anchorPos = recthelper.rectToRelativeAnchorPos(self.viewParam.pos, self.viewGO.transform.parent)

	recthelper.setAnchor(self._rootTrans, anchorPos.x, anchorPos.y)

	if self.viewParam.isMarbals then
		local type = self.viewParam.type
		local resCo = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][type]

		if not resCo then
			return
		end

		self._txtdesc.text = resCo.desc
	else
		local type = self.viewParam.type
		local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][type]

		if not resCo then
			return
		end

		self._txtdesc.text = resCo.tips
	end
end

return PinballCurrencyTipView

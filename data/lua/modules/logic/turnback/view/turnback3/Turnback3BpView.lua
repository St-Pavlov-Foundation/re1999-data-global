-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpView", package.seeall)

local Turnback3BpView = class("Turnback3BpView", BaseView)

function Turnback3BpView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg")
	self._txttips = gohelper.findChildText(self.viewGO, "root/top/#txt_tips")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/top/#simage_title")
	self._gobottomleft = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomleft")
	self._btnbottomleft = gohelper.findChildButton(self.viewGO, "root/bottom/#go_bottomleft/#btn_bottomleft")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/bottom/#go_bottomleft/#txt_num")
	self._gobottomright = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomright")
	self._btnbottomright = gohelper.findChildButton(self.viewGO, "root/bottom/#go_bottomright/#go_unlockbtn/#btn_bottomright")
	self._goextrareward = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomright/#go_extrareward")
	self._goextrarewardhasget = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomright/#go_extrarewardhasget")
	self._gounlockbtn = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomright/#go_unlockbtn")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/bottom/#go_bottomright/#go_unlockbtn/#simage_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/bottom/#go_bottomright/#go_unlockbtn/#txt_price")
	self._goToggleGroup = gohelper.findChild(self.viewGO, "root/top/toggleGroup")
	self._btnhelp = gohelper.findChildButton(self.viewGO, "root/#btn_tips")
	self._gorewardred = gohelper.findChild(self.viewGO, "root/top/redDot/redDot1")
	self._gotaskred = gohelper.findChild(self.viewGO, "root/top/redDot/redDot2")
	self._gohasbuy = gohelper.findChild(self.viewGO, "root/bottom/#go_bottomright/#go_unlockbtn/go_hasbuy")
	self._btnList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BpView:addEvents()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshPoint, self)
	self._btnbottomleft:AddClickListener(self._onClickBottomLeft, self)
	self._btnbottomright:AddClickListener(self._onClickBottomRight, self)
	self._btnhelp:AddClickListener(self._onClickHelpBtn, self)
	self:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
end

function Turnback3BpView:removeEvents()
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self._btnbottomleft:RemoveClickListener()
	self._btnbottomright:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
end

function Turnback3BpView:_onClickHelpBtn()
	HelpController.instance:openBpRuleTipsView(luaLang("Turnback3BpViewTipTitle"), "Rule Details", luaLang("Turnback3BpViewTipContent"))
end

function Turnback3BpView:_onClickBottomLeft()
	self.viewContainer:clickToggleBtn(TurnbackEnum.BpBtn.Task)
end

function Turnback3BpView:_onClickBottomRight()
	TurnbackController.instance:openTurnback3BpBuyView()
end

function Turnback3BpView:_editableInitView()
	self:_initToggle()
end

function Turnback3BpView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self.viewContainer:setCurrencyType({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon
	})

	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:_refreshPoint()

	self._config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

	local temp = not string.nilorempty(self._config.buyDoubleBonusPrice) and string.splitToNumber(self._config.buyDoubleBonusPrice, "#")

	self._txtprice.text = temp and temp[3]

	self:_refreshBottomRight()
	RedDotController.instance:addRedDot(self._gorewardred, RedDotEnum.DotNode.TurnbackBpReward)
	RedDotController.instance:addRedDot(self._gotaskred, RedDotEnum.DotNode.TurnbackBpTask)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.CloseMapView)
end

function Turnback3BpView:onOpenFinish()
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnViewOpenFinish)
end

function Turnback3BpView:_initToggle()
	self._toggleWraps = self:getUserDataTb_()

	local toggleCount = self._goToggleGroup.transform.childCount

	for i = 1, toggleCount do
		local toggleGo = self._goToggleGroup.transform:GetChild(i - 1).gameObject
		local toggleGomp = toggleGo:GetComponent(gohelper.Type_Toggle)

		if toggleGomp then
			local toggle = {}

			toggle.label = gohelper.findChildText(toggleGo, "Label")
			self._toggleWraps[i] = toggle
		end
	end
end

function Turnback3BpView:_toSwitchTab(tabContainerId, toggleId)
	for k, v in ipairs(self._toggleWraps) do
		SLFramework.UGUI.GuiHelper.SetColor(v.label, k == toggleId and "#ffffff" or "#000000")
	end

	self._tabIndex = toggleId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_act)
end

function Turnback3BpView:_refreshPoint()
	local currentPoint = TurnbackModel.instance:getCurrentPointId(self._turnbackId)

	self._txtnum.text = currentPoint
end

function Turnback3BpView:_refreshBottomRight()
	local hasDouble = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(self._goextrareward, not hasDouble)
	gohelper.setActive(self._gohasbuy, hasDouble)
	gohelper.setActive(self._goextrarewardhasget, hasDouble)
end

function Turnback3BpView:succbuydoublereward()
	self:_refreshBottomRight()
end

function Turnback3BpView:onClose()
	return
end

function Turnback3BpView:onDestroyView()
	return
end

return Turnback3BpView

-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceView.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceView", package.seeall)

local Rouge2_MapDiceView = class("Rouge2_MapDiceView", BaseView)

function Rouge2_MapDiceView:onInitView()
	self._imageRateAttribute = gohelper.findChildImage(self.viewGO, "root/#go_Info/Rate/#image_Attribute")
	self._txtRate = gohelper.findChildText(self.viewGO, "root/#go_Info/Rate/#txt_Rate")
	self._goFixList = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#go_FixList")
	self._goFixItem = gohelper.findChild(self.viewGO, "root/#go_Info/Value/#go_FixList/#go_FixItem")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Tips")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_Target")
	self._goDice = gohelper.findChild(self.viewGO, "root/#go_Dice")
	self._goDiceItem = gohelper.findChild(self.viewGO, "root/#go_Dice/#go_DiceItem")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Click")
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Jump")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._goResult = gohelper.findChild(self.viewGO, "root/#go_Result")
	self._goFailure = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Failure")
	self._goSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_Succeed")
	self._goBigSucceed = gohelper.findChild(self.viewGO, "root/#go_Result/#go_BigSucceed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapDiceView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_MapDiceView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_MapDiceView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_MapDiceView:_editableInitView()
	gohelper.setActive(self._goResult, false)
	gohelper.setActive(self._goFailure, false)
	gohelper.setActive(self._goSucceed, false)
	gohelper.setActive(self._goBigSucceed, false)
	gohelper.setActive(self._goDiceItem, false)
	gohelper.setActive(self._goFixItem, false)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._btnJump.gameObject, false)
	gohelper.setActive(self._btnClick.gameObject, true)

	self._fixItemTab = self:getUserDataTb_()

	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc, self)
end

function Rouge2_MapDiceView:onUpdateParam()
	return
end

function Rouge2_MapDiceView:onOpen()
	self:refreshInfo()
	self:refreshTitle()
	self:refreshFixUI()
end

function Rouge2_MapDiceView:refreshInfo()
	self._checkCo = self.viewParam and self.viewParam.checkCo
	self._checkResInfo = self.viewParam and self.viewParam.checkResInfo
	self._checkId = self._checkResInfo and self._checkResInfo.checkId
	self._checkDiceRes = self._checkResInfo and GameUtil.splitString2(self._checkResInfo.checkDiceRes, true)
	self._checkRes = self._checkResInfo and self._checkResInfo.checkRes
	self._resRate = self._checkResInfo and self._checkResInfo.resRate or 0
	self._fixValue = self._checkResInfo and self._checkResInfo.fixValue or 0
	self._attributeId = self._checkCo and self._checkCo.attrType
	self._attributeCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attributeId)
	self._isSucceed = self._checkRes ~= Rouge2_MapEnum.AttrCheckResult.Failure
end

function Rouge2_MapDiceView:refreshTitle()
	local targetCheckCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.Succeed)
	local targetPointRange = targetCheckCo and string.splitToNumber(targetCheckCo.checkPoint, "#")
	local targetCheckPoint = targetPointRange and targetPointRange[1] or 0

	self._txtTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_target"), targetCheckPoint)

	local exCheckCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(self._checkId, Rouge2_MapEnum.AttrCheckResult.BigSucceed)
	local exPointRange = exCheckCo and string.splitToNumber(exCheckCo.checkPoint, "#")
	local exCheckPoint = exPointRange and exPointRange[1] or 0

	self._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_mapdiceview_tips"), exCheckPoint)
end

function Rouge2_MapDiceView:refreshFixUI()
	self._txtRate.text = Rouge2_MapAttrCheckHelper.formatCheckRate(self._resRate)

	Rouge2_IconHelper.setAttributeIcon(self._attributeId, self._imageRateAttribute, Rouge2_Enum.AttrIconSuffix.Tag)

	local fixInfoList = {
		{
			fixValue = self._fixValue,
			fixAttrId = self._attributeId
		}
	}

	for index, fixInfo in ipairs(fixInfoList) do
		local fixItem = self:_getOrCreateFixItem(index)

		self:_refreshFixItem(fixItem, fixInfo, index)
	end
end

function Rouge2_MapDiceView:_getOrCreateFixItem(index)
	local fixItem = self._fixItemTab[index]

	if not fixItem then
		fixItem = self:getUserDataTb_()
		fixItem.go = gohelper.cloneInPlace(self._goFixItem, index)
		fixItem.txtFixValue = gohelper.findChildText(fixItem.go, "txt_FixValue")
		fixItem.txtAttrName = gohelper.findChildText(fixItem.go, "txt_AttrName")
		fixItem.imageAttrIcon = gohelper.findChildImage(fixItem.go, "image_AttrIcon")
		fixItem.goFlyEffect = gohelper.findChild(fixItem.go, "txt_FixValue/#go_flyitem")
		fixItem.fixValue = 0
		fixItem.done = false
		self._fixItemTab[index] = fixItem
	end

	return fixItem
end

function Rouge2_MapDiceView:getFixItemList()
	return self._fixItemTab
end

function Rouge2_MapDiceView:_refreshFixItem(obj, fixInfo, index)
	local fixValue = fixInfo.fixValue
	local fixAttrId = fixInfo.fixAttrId
	local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(fixAttrId)

	obj.fixValue = fixValue
	obj.txtFixValue.text = string.format("+%s", fixValue)
	obj.txtAttrName.text = attrCo and attrCo.name

	Rouge2_IconHelper.setAttributeIcon(fixAttrId, obj.imageAttrIcon, Rouge2_Enum.AttrIconSuffix.Tag)
	gohelper.setActive(obj.goFlyEffect, false)
	gohelper.setActive(obj.go, true)
end

function Rouge2_MapDiceView:onClose()
	return
end

function Rouge2_MapDiceView:onDestroyView()
	return
end

return Rouge2_MapDiceView

-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpView.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpView", package.seeall)

local Rouge2_MapAttributeUpView = class("Rouge2_MapAttributeUpView", BaseView)
local DefalutSelectIndex = 1
local AddAttributeDuration = 1
local SpecialAddAttrDuration = 3
local DelayPlayAttrUpAnim = 0.1
local PercentColor = "#B84E32"
local BracketColor = "#5E7DD9"

function Rouge2_MapAttributeUpView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goAttributeMapPos = gohelper.findChild(self.viewGO, "#go_Root/#go_AttributeMapPos")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Container")
	self._imageAttributeIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Base/#image_AttributeIcon")
	self._txtAttributeName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_AttributeName")
	self._txtWorldDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_worldDesc")
	self._txtCurAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_CurAttribute")
	self._txtNextAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_NextAttribute")
	self._goToast = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast")
	self._txtCurAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_CurAttribute")
	self._txtNextAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_NextAttribute")
	self._goCurviewContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_CurviewList")
	self._goCurviewItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_CurviewList/#go_CurviewItem")
	self._scrollPreview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Container/#scroll_Preview")
	self._goPreview = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Preview")
	self._goPreviewContent = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Preview/#go_PreviewList")
	self._goPreviewItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Preview/#go_PreviewList/#go_PreviewItem")
	self._goMax = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_Max")
	self._txtRemainAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#txt_RemainAttribute")
	self._goRemain = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Remain")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add", AudioEnum.Rouge2.AddAttr)
	self._imageAttributeIcon2 = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#image_AttributeIcon")
	self._txtUp = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#txt_Up")
	self._goPassiveSkill = gohelper.findChild(self.viewGO, "#go_Root/#go_PassiveSkill")
	self._txtPassiveDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_PassiveSkill/#txt_PassiveDesc")
	self._goToastContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer")
	self._goBigToast = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast")
	self._txtBigToast = gohelper.findChildText(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast/root/#txt_BigToast")
	self._goToastList = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList")
	self._goToastItem = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList/#go_ToastItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Root/#go_Block")
	self._goEffectTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips")
	self._txtEffect = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips/#txt_effect")
	self._goHasRelics = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Collection/has")
	self._goEmptyRelics = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Collection/empty")
	self._goRelicsList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Collection/has/layout")
	self._btnRelicsTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Container/Collection/has/#btn_RelicsTips")
	self._goRelicsItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Collection/has/layout/#go_collectionitem")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_PassiveSkill/#btn_Skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapAttributeUpView:addEvents()
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self._btnRelicsTips:AddClickListener(self._btnRelicsTipsOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareerAttribute, self._onSelectCareerAttribute, self)
end

function Rouge2_MapAttributeUpView:removeEvents()
	self._btnAdd:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self._btnRelicsTips:RemoveClickListener()
end

function Rouge2_MapAttributeUpView:_btnAddOnClick()
	if not self._addAttrPoint or self._addAttrPoint <= 0 or not self._selectAttrId then
		return
	end

	if self._isMax then
		GameFacade.showToast(ToastEnum.Rouge2MaxAttr)

		return
	end

	self._isPlayingLightAnim = true

	self._remainAnimator:Play("light", self._onLightAnimDone, self)

	self._waitRpc = true

	Rouge2_Rpc.instance:sendRouge2AddCareerAttrPointRequest(self._selectAttrId, Rouge2_MapEnum.AddAttrStep, function(__, resultCode)
		if resultCode ~= 0 then
			self:_debugErrorInfo()
			self:closeThis()

			return
		end

		self._waitRpc = false

		local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
		local addAttrPoint = curInteractive and curInteractive.addAttrPoint or 0

		self._addAttrPoint = addAttrPoint or 0
		self._costAddAttrPoint = self._costAddAttrPoint + 1

		self:_onUpdateAttributeInfo()
	end)
end

function Rouge2_MapAttributeUpView:_debugErrorInfo()
	local attrValue = Rouge2_Model.instance:getAttrValue(self._selectAttrId)
	local preAddAttrPoint = self._addAttrPoint
	local curInteractive = Rouge2_MapModel.instance:getCurInteractiveJson()
	local addAttrPoint = curInteractive and curInteractive.addAttrPoint or 0
	local curAddAttrPoint = addAttrPoint or 0
	local eventCo = Rouge2_MapModel.instance:getCurEvent()
	local eventId = eventCo and eventCo.id or 0

	logError(string.format("肉鸽属性加点参数错误: attrId = %s, attrValue = %s, preAddAttrPoint = %s, curAddAttrPoint = %s, initAttrPoint = %s, costAttrPoint = %s, eventId = %s", self._selectAttrId, attrValue, preAddAttrPoint, curAddAttrPoint, self._initAddAttrPoint, self._costAddAttrPoint, eventId))
end

function Rouge2_MapAttributeUpView:_onLightAnimDone()
	self._isPlayingLightAnim = false

	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_MapAttributeUpView:_btnSkipOnClick()
	self:_skipPassiveSkill(false)
	self._skillAnimator:Play("close", self._onPassiveSkillCloseAnimDone, self)
end

function Rouge2_MapAttributeUpView:_btnRelicsTipsOnClick()
	if not self._hasRelicsIdList or #self._hasRelicsIdList <= 0 then
		return
	end

	local showViewName = Rouge2_BackpackHelper.itemType2ShowViewName(Rouge2_Enum.BagType.Relics)

	ViewMgr.instance:openView(showViewName, {
		viewEnum = Rouge2_MapEnum.ItemDropViewEnum.Tips,
		dataType = Rouge2_Enum.ItemDataType.Config,
		itemList = self._hasRelicsIdList
	})
end

function Rouge2_MapAttributeUpView:_onPassiveSkillCloseAnimDone()
	gohelper.setActive(self._goPassiveSkill, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSkilPassiveSkillTips)
end

function Rouge2_MapAttributeUpView:_skipPassiveSkill(isSkip)
	gohelper.setActive(self._btnSkip.gameObject, isSkip)
end

function Rouge2_MapAttributeUpView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)

	local goAttributeMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._goAttributeMapPos)

	self._comAttrMap = Rouge2_CareerAttributeMap.Get(goAttributeMap, Rouge2_Enum.AttrMapUsage.MapAttributeUpView)

	self._comAttrMap:setCanClickDetail(false)

	self._remainAnimator = SLFramework.AnimatorPlayer.Get(self._goRemain)
	self._skillAnimator = SLFramework.AnimatorPlayer.Get(self._goPassiveSkill)
	self._addAttrPoint = 0
	self._first = true
	self._relicsIconTab = self:getUserDataTb_()

	gohelper.setActive(self._goBlock, false)
	gohelper.setActive(self._goToast, false)
	gohelper.setActive(self._goPassiveSkill, false)
	gohelper.setActive(self._goToastContainer, false)
	gohelper.setActive(self._btnClose.gameObject, false)
	SkillHelper.addHyperLinkClick(self._txtEffect)
	NavigateMgr.instance:removeEscape(self.viewName)
	self:initCustomAttrList()
end

function Rouge2_MapAttributeUpView:onUpdateParam()
	return
end

function Rouge2_MapAttributeUpView:onOpen()
	self._careerId = Rouge2_Model.instance:getCareerId()

	self:initInfo()
	self:refreshUI()

	self._isDealyPlay = self._addAttrPoint and self._addAttrPoint > 0

	if not self._isDealyPlay then
		self:buildAttrUpFlow()
	end
end

function Rouge2_MapAttributeUpView:onOpenFinish()
	if self._isDealyPlay then
		self:buildAttrUpFlow()
	end
end

function Rouge2_MapAttributeUpView:initInfo()
	self._addAttrPoint = self.viewParam and self.viewParam.addAttrPoint or 0
	self._initAddAttrPoint = self._addAttrPoint or 0
	self._costAddAttrPoint = 0

	self:initCustomAttrValue()
	self:initAttrMap()
end

function Rouge2_MapAttributeUpView:initCustomAttrList()
	local curAttrList = Rouge2_Model.instance:getHeroAttrInfoList()

	self._customAttrList = {}
	self._customAttrMap = {}

	for _, attributeMo in ipairs(curAttrList) do
		local customAttrMo = tabletool.copy(attributeMo)
		local attrId = customAttrMo.attrId

		self._customAttrMap[attrId] = customAttrMo

		table.insert(self._customAttrList, customAttrMo)
	end
end

function Rouge2_MapAttributeUpView:initCustomAttrValue()
	local updateAttrMap = Rouge2_Model.instance:getUpdateAttrMap() or {}

	self._updateAttrMap = tabletool.copy(updateAttrMap)
	self._show = self._addAttrPoint > 0
	self._hasUpdateAttr = false

	for attrId, updateValue in pairs(self._updateAttrMap) do
		if self._customAttrMap[attrId] then
			local customAttrValue = self._customAttrMap[attrId].value

			self._customAttrMap[attrId].value = customAttrValue - updateValue
			self._hasUpdateAttr = self._hasUpdateAttr or updateValue > 0
			self._show = self._show or self._hasUpdateAttr
		end
	end

	Rouge2_Model.instance:clearUpdateAttrMap()
end

function Rouge2_MapAttributeUpView:initAttrMap()
	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)

	if not self._comAttrMap:getCurSelectAttrId() then
		self._comAttrMap:selectAttribute(DefalutSelectIndex)
	end

	for _, attrMo in ipairs(self._customAttrList) do
		self._comAttrMap:selectAttributeById(attrMo.attrId)

		break
	end
end

function Rouge2_MapAttributeUpView:buildAttrUpFlow()
	self:_lockScreen(false)

	if not self._show then
		gohelper.setActive(self._btnClose.gameObject, true)
		NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
		self:destroyFlow()

		return
	end

	if not self._hasUpdateAttr then
		return
	end

	self:destroyFlow()
	self:_lockScreen(true)
	gohelper.setActive(self._btnClose.gameObject, false)

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
	self._flow:addWork(WorkWaitSeconds.New(self._first and DelayPlayAttrUpAnim or 0))

	for _, attrMo in ipairs(self._customAttrList) do
		self:_buildUpAttributeFlow(self._flow, attrMo)
	end

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	self._flow:registerDoneListener(self._onAttrUpFlowDone, self)
	self._flow:start()

	self._first = false
end

function Rouge2_MapAttributeUpView:_buildUpAttributeFlow(flow, customAttrMo)
	local attrId = customAttrMo.attrId
	local update = self._updateAttrMap[attrId] or 0

	if update == 0 then
		return
	end

	local from = customAttrMo.value or 0
	local to = from + update

	for i = from + 1, to do
		local skillCo = Rouge2_AttributeConfig.instance:getCareerPassiveSkill(self._careerId, self._selectAttrId, i)
		local isSpecial = skillCo and skillCo.isSpecial ~= 0
		local params = {
			type = "DOTweenFloat",
			from = i - 1,
			to = i,
			t = isSpecial and SpecialAddAttrDuration or AddAttributeDuration,
			frameCb = self._attrValueFrameCallback,
			cbObj = self,
			param = attrId
		}
		local parallel = FlowParallel.New()
		local stepFlow = FlowSequence.New()

		parallel:addWork(stepFlow)
		stepFlow:addWork(FunctionWork.New(self._comAttrMap.selectAttributeById, self._comAttrMap, attrId))
		stepFlow:addWork(TweenWork.New(params))

		if isSpecial then
			parallel:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onSkilPassiveSkillTips"))
		end

		stepFlow:addWork(FunctionWork.New(self._hideAllToast, self))
		flow:addWork(parallel)
	end
end

function Rouge2_MapAttributeUpView:_attrValueFrameCallback(value, attrId)
	local resultValue = math.ceil(value)
	local curAttrValue = self._customAttrMap[attrId].value

	if not curAttrValue or curAttrValue == resultValue then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.AttrUp)

	self._customAttrMap[attrId].value = resultValue

	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)
	self:updateSelectInfo()
	self:checkPassiveSkill()
	self:checkLevelupToast()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_onAttrUpFlowDone()
	self._updateAttrMap = {}

	gohelper.setActive(self._btnClose.gameObject, self._addAttrPoint <= 0)
	self:_hideAllToast()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_hideAllToast()
	gohelper.setActive(self._goToast, false)
	gohelper.setActive(self._goToastContainer, false)
end

function Rouge2_MapAttributeUpView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapAttributeUpView:_onSelectCareerAttribute(attrId)
	self._selectAttrId = attrId

	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:refreshUI()
	self:refreshSelectUI()
	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:updateSelectInfo()
	if not self._selectAttrId or not self._customAttrMap[self._selectAttrId] then
		return
	end

	self._selectAttrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._selectAttrId)
	self._maxAttrValue = Rouge2_AttributeConfig.instance:getAttrMaxValue(self._selectAttrId)
	self._curAttrValue = self._customAttrMap and self._customAttrMap[self._selectAttrId].value or 0
	self._nextAttrValue = self._curAttrValue + Rouge2_MapEnum.AddAttrStep
	self._isMax = self._curAttrValue >= self._maxAttrValue
	self._selectPassiveSkillCo = Rouge2_AttributeConfig.instance:getCareerPassiveSkill(self._careerId, self._selectAttrId, self._curAttrValue)
	self._selectAttrName = self._selectAttrCo and self._selectAttrCo.name or ""

	if not self._isMax then
		self._nextSpSkillCo = Rouge2_AttributeConfig.instance:getNextSpPassiveSkill(self._careerId, self._selectAttrId, self._curAttrValue)
		self._nextSpSkillId = self._nextSpSkillCo and self._nextSpSkillCo.id
		self._nextSpSkillLevel = self._nextSpSkillCo and self._nextSpSkillCo.level
		self._nextSpSkillDesc = self._nextSpSkillCo and Rouge2_AttributeConfig.instance:getPassiveSkillImLevelUpDesc(self._nextSpSkillId, self._nextSpSkillLevel) or ""
		self._nextSpSkillDesc = SkillHelper.buildDesc(self._nextSpSkillDesc, PercentColor, BracketColor) or ""
	else
		self._nextSpSkillCo = nil
	end
end

function Rouge2_MapAttributeUpView:refreshSelectUI()
	gohelper.setActive(self._goContainer, self._selectAttrId and self._selectAttrId ~= 0)

	if not self._selectAttrId then
		return
	end

	self._txtAttributeName.text = self._selectAttrName
	self._txtWorldDesc.text = self._selectAttrCo and self._selectAttrCo.careerDesc
	self._txtCurAttribute.text = self._curAttrValue
	self._txtCurAttribute2.text = self._curAttrValue
	self._txtNextAttribute.text = self._isMax and "MAX" or self._nextAttrValue
	self._txtNextAttribute2.text = self._isMax and "MAX" or self._nextAttrValue

	if self._nextSpSkillCo then
		self._txtEffect.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("rouge2_effecttips"), self._nextSpSkillLevel, self._selectAttrName, self._nextSpSkillDesc)
	else
		self._txtEffect.text = luaLang("rouge2_attributeupview_maxpassiveskill")
	end

	gohelper.setActive(self._goMax, self._isMax)
	gohelper.setActive(self._goPreview, not self._isMax)

	if not self._isMax then
		local effectDescList = Rouge2_AttributeConfig.instance:getPassiveSkillUpDescList(self._careerId, self._selectAttrId, self._nextAttrValue)

		gohelper.CreateObjList(self, self._refreshNextAttrEffectDesc, effectDescList, self._goPreviewContent, self._goPreviewItem)
	end

	local curEffectDescList = Rouge2_AttributeConfig.instance:getPassiveSkillDescList(self._careerId, self._selectAttrId, self._curAttrValue)

	gohelper.CreateObjList(self, self._refreshCurAttrEffectDesc, curEffectDescList, self._goCurviewContent, self._goCurviewItem)
	Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon)
	Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon2)
	self:refreshRelicsList()
end

function Rouge2_MapAttributeUpView:_refreshNextAttrEffectDesc(obj, desc, index)
	local txtEffect = gohelper.findChildText(obj, "txt_Effect")

	txtEffect.text = SkillHelper.buildDesc(desc, PercentColor, BracketColor)

	SkillHelper.addHyperLinkClick(txtEffect)
end

function Rouge2_MapAttributeUpView:_refreshCurAttrEffectDesc(obj, desc, index)
	local txtEffect = gohelper.findChildText(obj, "txt_Effect")

	txtEffect.text = SkillHelper.buildDesc(desc, PercentColor, BracketColor)

	SkillHelper.addHyperLinkClick(txtEffect)
end

function Rouge2_MapAttributeUpView:refreshFreeUI()
	gohelper.setActive(self._goRemain, self._addAttrPoint > 0 or self._isPlayingLightAnim)

	self._txtRemainAttribute.text = self._addAttrPoint
	self._txtUp.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attributeupview_up"), Rouge2_MapEnum.AddAttrStep)
end

function Rouge2_MapAttributeUpView:refreshRelicsList()
	local relicsList = Rouge2_CollectionConfig.instance:getAttrUpdateRelicsList(self._selectAttrId, self._curAttrValue)

	self._hasRelcisList = {}
	self._hasRelicsIdList = {}

	if relicsList then
		for _, relicsInfo in ipairs(relicsList) do
			local relicsCo = relicsInfo.config
			local relicsId = relicsCo and relicsCo.id
			local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(relicsId)

			if itemList and #itemList > 0 then
				table.insert(self._hasRelcisList, relicsInfo)
				table.insert(self._hasRelicsIdList, relicsId)
			end
		end
	end

	local relicsNum = self._hasRelcisList and #self._hasRelcisList or 0

	gohelper.setActive(self._goHasRelics, relicsNum > 0)
	gohelper.setActive(self._goEmptyRelics, relicsNum <= 0)

	if relicsNum <= 0 then
		return
	end

	gohelper.CreateObjList(self, self._refreshRelicsItem, self._hasRelcisList, self._goRelicsList, self._goRelicsItem)
end

function Rouge2_MapAttributeUpView:_refreshRelicsItem(obj, relicsInfo, index)
	local imageRare = gohelper.findChildImage(obj, "#image_rare")
	local simageIcon = gohelper.findChildSingleImage(obj, "#simage_icon")
	local txtNum1 = gohelper.findChildText(obj, "#txt_num1")
	local txtNum2 = gohelper.findChildText(obj, "#txt_num2")
	local attrValue = relicsInfo.attrValue
	local relicsCo = relicsInfo.config
	local relicsId = relicsCo and relicsCo.id

	txtNum1.text = self._curAttrValue
	txtNum2.text = attrValue

	Rouge2_IconHelper.setRelicsRareIcon(relicsId, imageRare)
	Rouge2_IconHelper.setRelicsIcon(relicsId, simageIcon)

	self._relicsIconTab[index] = simageIcon
end

function Rouge2_MapAttributeUpView:checkLevelupToast()
	local levelUpDesc = self._selectPassiveSkillCo and self._selectPassiveSkillCo.levelUpDesc
	local hasDesc = not string.nilorempty(levelUpDesc)

	gohelper.setActive(self._goToastContainer, hasDesc)

	if not hasDesc then
		return
	end

	local descList = string.split(levelUpDesc, "|")
	local bigDesc = descList and descList[1]
	local hasBigToast = not string.nilorempty(bigDesc)

	gohelper.setActive(self._goBigToast, hasBigToast)

	if hasBigToast then
		self._txtBigToast.text = bigDesc
	end

	local smallDescList = {}

	for i = 2, descList and #descList do
		table.insert(smallDescList, descList[i])
	end

	gohelper.CreateObjList(self, self._refreshLevelUpDesc, smallDescList, self._goToastList, self._goToastItem)
end

function Rouge2_MapAttributeUpView:_refreshLevelUpDesc(obj, desc, index)
	local txtToast = gohelper.findChildText(obj, "root/txt_Toast")

	txtToast.text = desc
end

function Rouge2_MapAttributeUpView:checkPassiveSkill()
	local isSpecial = self._selectPassiveSkillCo and self._selectPassiveSkillCo.isSpecial ~= 0

	gohelper.setActive(self._goToast, true)
	gohelper.setActive(self._goPassiveSkill, isSpecial)

	if not isSpecial then
		return
	end

	self:_skipPassiveSkill(false)
	self._skillAnimator:Play("open", self._onPassiveSkillOpenAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.FeatureUp)

	local levelUpDesc = Rouge2_AttributeConfig.instance:getPassiveSkillImLevelUpDesc(self._selectPassiveSkillCo.id, self._selectPassiveSkillCo.level)

	self._txtPassiveDesc.text = SkillHelper.buildDesc(levelUpDesc, PercentColor, BracketColor)
end

function Rouge2_MapAttributeUpView:_onPassiveSkillOpenAnimDone()
	self:_skipPassiveSkill(true)
end

function Rouge2_MapAttributeUpView:_onUpdateAttrInfo()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_onUpdateAttributeInfo()
	if self._waitRpc or self._flow and self._flow.status == WorkStatus.Running then
		return
	end

	self:initCustomAttrList()
	self:initCustomAttrValue()
	self:buildAttrUpFlow()
	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_lockScreen(lock)
	gohelper.setActive(self._goBlock, lock)
end

function Rouge2_MapAttributeUpView:onClose()
	self:_lockScreen(false)
	self:destroyFlow()

	if self._relicsIconTab then
		for _, relcisIcon in pairs(self._relicsIconTab) do
			relcisIcon:UnLoadImage()
		end
	end
end

function Rouge2_MapAttributeUpView:onDestroyView()
	return
end

return Rouge2_MapAttributeUpView

-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_TeamRecommendTips.lua

module("modules.logic.rouge2.common.comp.Rouge2_TeamRecommendTips", package.seeall)

local Rouge2_TeamRecommendTips = class("Rouge2_TeamRecommendTips", LuaCompBase)
local CS_TweenHelper = ZProj.TweenHelper
local kEaseType = EaseType.Linear
local kDurationDefault_LayoutPingpong = 5
local kDurationDefault_LayoutStop = 3

function Rouge2_TeamRecommendTips:_delayTweenDefault_Layout(callback)
	TaskDispatcher.cancelTask(self._tweenDefault_LayoutFlip, self)
	TaskDispatcher.cancelTask(self._tweenDefault_Layout, self)
	TaskDispatcher.runDelay(callback, self, kDurationDefault_LayoutStop)
end

function Rouge2_TeamRecommendTips:_tweenDefault_Layout()
	TaskDispatcher.cancelTask(self._tweenDefault_Layout, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_Default_LayoutTweenId")

	if self._Default_Layout_endPosX >= 0 then
		return
	end

	local toPosX = self._Default_Layout_endPosX

	self._Default_LayoutTweenId = CS_TweenHelper.DOAnchorPosX(self._Default_Layout_transform, toPosX, kDurationDefault_LayoutPingpong, self._delayTweenDefault_Layout, self, self._tweenDefault_LayoutFlip, kEaseType)
end

function Rouge2_TeamRecommendTips:_tweenDefault_LayoutFlip()
	TaskDispatcher.cancelTask(self._tweenDefault_LayoutFlip, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_Default_LayoutTweenId")

	if self._Default_Layout_endPosX >= 0 then
		return
	end

	local toPosX = 0

	self._Default_LayoutTweenId = CS_TweenHelper.DOAnchorPosX(self._Default_Layout_transform, toPosX, kDurationDefault_LayoutPingpong, self._delayTweenDefault_Layout, self, self._tweenDefault_Layout, kEaseType)
end

Rouge2_TeamRecommendTips.Pivot_LeftCenter = Vector2(0, 0.5)
Rouge2_TeamRecommendTips.Pivot_MiddleCenter = Vector2(0.5, 0.5)

function Rouge2_TeamRecommendTips:ctor(loader)
	self._loader = loader
end

function Rouge2_TeamRecommendTips:init(go)
	self._Default_Layout_endPosX = 0
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")

	self:_initTypeList()
	self:_initButtons()
end

function Rouge2_TeamRecommendTips:_initTypeList()
	self._goTypeTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goType = gohelper.findChild(self.go, "#go_Root/#go_Type" .. i)

		if gohelper.isNil(goType) then
			break
		end

		self._goTypeTab[i] = goType

		gohelper.setActive(goType, false)
	end
end

function Rouge2_TeamRecommendTips:_initButtons()
	self._btnDetail1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type1/go_Detail/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type2/go_Title/title/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail3_1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type3/#go_Unselect/title/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail3_2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type3/#go_Select/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail9_1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type9/#go_Unselect/title/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail9_2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type9/#go_Select/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
end

function Rouge2_TeamRecommendTips:addEventListeners()
	self._btnDetail1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail2:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail3_1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail3_2:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail9_1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail9_2:AddClickListener(self._btnDetailOnClick, self)
	self:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateTeamSystem, self._onUpdateTeamSystem, self)
end

function Rouge2_TeamRecommendTips:removeEventListeners()
	self._btnDetail1:RemoveClickListener()
	self._btnDetail2:RemoveClickListener()
	self._btnDetail3_1:RemoveClickListener()
	self._btnDetail3_2:RemoveClickListener()
	self._btnDetail9_1:RemoveClickListener()
	self._btnDetail9_2:RemoveClickListener()
end

function Rouge2_TeamRecommendTips:_btnDetailOnClick()
	local param = {
		careerId = self._careerId
	}

	ViewMgr.instance:openView(ViewName.Rouge2_SystemSelectView, param)
end

function Rouge2_TeamRecommendTips:updateInfo(showType, careerId, params)
	self._showType = showType
	self._careerId = careerId
	self._params = params

	self:refreshUI()
end

function Rouge2_TeamRecommendTips:refreshUI()
	self._curSystemId = Rouge2_Model.instance:getCurTeamSystemId()
	self._isSelectSystem = self._curSystemId and self._curSystemId ~= 0
	self._selectSystemCo = self._isSelectSystem and Rouge2_CareerConfig.instance:getSystemConfig(self._curSystemId)
	self._selectTagCo = self._isSelectSystem and Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(self._curSystemId)
	self._recommendSystemIdList = Rouge2_CareerConfig.instance:getCareerRecommendTeamList(self._careerId) or {}

	self:showType2RefreshUI()
end

function Rouge2_TeamRecommendTips:showType2RefreshUI()
	TaskDispatcher.cancelTask(self._tweenDefault_LayoutFlip, self)
	TaskDispatcher.cancelTask(self._tweenDefault_Layout, self)
	GameUtil.onDestroyViewMember_TweenId(self, "_Default_LayoutTweenId")

	local refreshFunc = self:_showType2RefreshUIFunc(self._showType)
	local goType = self._showType and self._goTypeTab[self._showType]

	gohelper.setActive(goType, true)

	if refreshFunc then
		refreshFunc(self, goType)
	end
end

function Rouge2_TeamRecommendTips:_showType2RefreshUIFunc(showType)
	if not self._showTypeFunc then
		self._showTypeFunc = {}
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Default] = self._refresh_Default
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Default_Layout] = self._refresh_Default_Layout
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Single] = self._refresh_Single
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.System] = self._refresh_System
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Drop] = self._refresh_Drop
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.AttrBuffDrop] = self._refresh_AttrBuffDrop
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.MapStoreGoods] = self._refresh_MapStoreGoods
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.HeroCard] = self._refresh_HeroCard
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.HeroGroupEdit] = self._refresh_HeroGroupEdit
	end

	return self._showTypeFunc[showType]
end

function Rouge2_TeamRecommendTips:_refresh_Default(goType)
	local pivot = self._params and self._params.pivot

	pivot = pivot or Rouge2_TeamRecommendTips.Pivot_LeftCenter
	goType.transform.pivot = pivot

	local goLight = gohelper.findChild(goType, "go_Detail/#btn_Detail/icon/#light")

	gohelper.setActive(goLight, not self._isSelectSystem)

	local goTypeList = gohelper.findChild(goType, "#go_TypeList")
	local goTypeItem = gohelper.findChild(goType, "#go_TypeList/#go_TypeItem")

	gohelper.CreateObjList(self, self._refreshTeamTypeItem, self._recommendSystemIdList, goTypeList, goTypeItem)
end

function Rouge2_TeamRecommendTips:_refreshTeamTypeItem(obj, systemId, index)
	local goSelect = gohelper.findChild(obj, "go_Select")
	local txtSelectName = gohelper.findChildText(obj, "go_Select/txt_Name")
	local goUnselect = gohelper.findChild(obj, "go_Unselect")
	local txtUnselectName = gohelper.findChildText(obj, "go_Unselect/txt_Name")
	local goLine = gohelper.findChild(obj, "go_Line")
	local isSelect = systemId == self._curSystemId

	gohelper.setActive(goSelect, isSelect)
	gohelper.setActive(goUnselect, not isSelect)
	gohelper.setActive(goLine, index > 1)

	local tagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(systemId)

	txtSelectName.text = tagCo and tagCo.tagName
	txtUnselectName.text = tagCo and tagCo.tagName
end

function Rouge2_TeamRecommendTips:_refresh_Default_Layout(goType)
	local goTypeList_overseas = gohelper.findChild(goType, "#go_TypeList_overseas")
	local goTypeListContent = gohelper.findChild(goTypeList_overseas, "viewport/content")
	local goTypeItem_overseas = gohelper.findChild(goTypeListContent, "#go_TypeItem")

	self._Default_Layout_transform = goTypeListContent.transform

	local goTypeList = gohelper.findChild(goType, "#go_TypeList")
	local goTypeItem = gohelper.findChild(goType, "#go_TypeList/#go_TypeItem")
	local isUseScroll = true

	gohelper.setActive(goTypeList, not isUseScroll)
	gohelper.setActive(goTypeList_overseas, isUseScroll)

	if isUseScroll then
		goTypeList = goTypeListContent
		goTypeItem = goTypeItem_overseas
	end

	gohelper.CreateObjList(self, self._refreshTeamTypeItem, self._recommendSystemIdList, goTypeList, goTypeItem)

	local goLight = gohelper.findChild(goType, "go_Title/title/#btn_Detail/#light")

	gohelper.setActive(goLight, not self._isSelectSystem)

	if isUseScroll then
		ZProj.UGUIHelper.RebuildLayout(self._Default_Layout_transform)

		local contentW = recthelper.getWidth(self._Default_Layout_transform)
		local viewportW = recthelper.getWidth(goTypeList_overseas.transform)

		self._Default_Layout_endPosX = viewportW - contentW
	else
		self._Default_Layout_endPosX = 0
	end

	self:_tweenDefault_Layout()
end

function Rouge2_TeamRecommendTips:_refresh_Single(goType)
	local goSelect = gohelper.findChild(goType, "#go_Select")
	local goUnselect = gohelper.findChild(goType, "#go_Unselect")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtSelectName = gohelper.findChildText(goType, "#go_Select/#txt_Name")

		txtSelectName.text = self._selectTagCo and self._selectTagCo.tagName
	end
end

function Rouge2_TeamRecommendTips:_refresh_System(goType)
	local goTypeList = gohelper.findChild(goType, "#go_TypeList")
	local goTypeItem = gohelper.findChild(goType, "#go_TypeList/#go_TypeItem")

	gohelper.CreateObjList(self, self._refreshTeamTypeItem, self._recommendSystemIdList, goTypeList, goTypeItem)
end

function Rouge2_TeamRecommendTips:_refresh_Drop(goType)
	local goSelect = gohelper.findChild(goType, "#go_Select")
	local goUnselect = gohelper.findChild(goType, "#go_Unselect")
	local txtSelectName = gohelper.findChildText(goType, "#go_Select/#txt_Name")
	local txtUnselectName = gohelper.findChildText(goType, "#go_Unselect/#txt_Name")
	local itemId = self._params and self._params.itemId
	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
	local battleTag = itemCo and itemCo.battleTag
	local isSelectSystem = battleTag == tostring(self._curSystemId)
	local tagCo = HeroConfig.instance:getBattleTagConfigCO(battleTag)

	txtSelectName.text = tagCo and tagCo.tagName
	txtUnselectName.text = tagCo and tagCo.tagName

	gohelper.setActive(goSelect, isSelectSystem)
	gohelper.setActive(goUnselect, not isSelectSystem)
end

function Rouge2_TeamRecommendTips:_refresh_AttrBuffDrop(goType)
	local heroNum = HeroModel.instance:getCount() or 0
	local itemId = self._params and self._params.itemId
	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
	local battleTag = itemCo and itemCo.battleTag
	local isSelectSystem = battleTag == tostring(self._curSystemId)

	gohelper.setActive(goType, heroNum > 0 and isSelectSystem)
end

function Rouge2_TeamRecommendTips:_refresh_MapStoreGoods(goType)
	local itemId = self._params and self._params.itemId
	local isBuff = Rouge2_BackpackHelper.isBuff(Rouge2_Enum.ItemDataType.Config, itemId)

	if not isBuff then
		gohelper.setActive(goType, false)

		return
	end

	local itemCo = Rouge2_BackpackHelper.getItemConfig(itemId)
	local battleTag = itemCo and itemCo.battleTag
	local isSelectSystem = battleTag == tostring(self._curSystemId)

	gohelper.setActive(goType, isSelectSystem)
end

function Rouge2_TeamRecommendTips:_refresh_HeroCard(goType)
	local heroId = self._params and self._params.heroId
	local isRecommend = Rouge2_SystemController.instance:isRecommendHero(heroId)

	gohelper.setActive(goType, isRecommend)
end

function Rouge2_TeamRecommendTips:_refresh_HeroGroupEdit(goType)
	local goSelect = gohelper.findChild(goType, "#go_Select")
	local goUnselect = gohelper.findChild(goType, "#go_Unselect")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtSelectName = gohelper.findChildText(goType, "#go_Select/#txt_Name")
		local tagName = self._selectTagCo and self._selectTagCo.tagName or ""

		txtSelectName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_teamrecommendtips_recommendteam"), tagName)
	end
end

function Rouge2_TeamRecommendTips:_onUpdateTeamSystem()
	self:refreshUI()
end

function Rouge2_TeamRecommendTips:_onUseStoneReply()
	self:refreshUI()
end

function Rouge2_TeamRecommendTips:onDestroy()
	GameUtil.onDestroyViewMember_TweenId(self, "_Default_LayoutTweenId")
	TaskDispatcher.cancelTask(self._tweenDefault_LayoutFlip, self)
	TaskDispatcher.cancelTask(self._tweenDefault_Layout, self)
end

return Rouge2_TeamRecommendTips

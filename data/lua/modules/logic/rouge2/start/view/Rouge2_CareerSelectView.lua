-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSelectView.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSelectView", package.seeall)

local Rouge2_CareerSelectView = class("Rouge2_CareerSelectView", BaseView)

function Rouge2_CareerSelectView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_RightArrow", AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	self._btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_LeftArrow", AudioEnum.UI.play_ui_achieve_weiqicard_switch)
	self._goCareer = gohelper.findChild(self.viewGO, "Career/#go_Career")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Career/bg/#txt_Descr")
	self._imageSkillIcon = gohelper.findChildImage(self.viewGO, "Initial/Skill/#image_SkillIcon")
	self._goRecommend = gohelper.findChild(self.viewGO, "#go_Recommand")
	self._txtRecommend = gohelper.findChildText(self.viewGO, "#go_Recommand/image_TipsBG/#txt_Recommend")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_Start", AudioEnum.Rouge2.NextStep)
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._scrollSkill = gohelper.findChildScrollRect(self.viewGO, "#scroll_Skill")
	self._goSkillList = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/Content/#go_SkillList")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/Content/#go_SkillList/#go_SkillItem")
	self._scrollRelics = gohelper.findChildScrollRect(self.viewGO, "#scroll_Relics")
	self._goRelicsList = gohelper.findChild(self.viewGO, "#scroll_Relics/Viewport/Content/#go_RelicsList")
	self._goRelicsItem = gohelper.findChild(self.viewGO, "#scroll_Relics/Viewport/Content/#go_RelicsList/#go_RelicsItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerSelectView:addEvents()
	self._btnRightArrow:AddClickListener(self._btnRightArrowOnClick, self)
	self._btnLeftArrow:AddClickListener(self._btnLeftArrowOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareer, self._onSelectCareer, self)
end

function Rouge2_CareerSelectView:removeEvents()
	self._btnRightArrow:RemoveClickListener()
	self._btnLeftArrow:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function Rouge2_CareerSelectView:_btnRightArrowOnClick()
	local isCan, toastId = Rouge2_CareerSelectListModel.instance:canSwitch(true)

	if not isCan then
		if toastId then
			GameFacade.showToast(toastId)
		end

		return
	end

	Rouge2_CareerSelectListModel.instance:switch2Next(true)
end

function Rouge2_CareerSelectView:_btnLeftArrowOnClick()
	local isCan, toastId = Rouge2_CareerSelectListModel.instance:canSwitch(false)

	if not isCan then
		if toastId then
			GameFacade.showToast(toastId)
		end

		return
	end

	Rouge2_CareerSelectListModel.instance:switch2Next(false)
end

function Rouge2_CareerSelectView:_btnStartOnClick()
	if not self._selectCareerId then
		return
	end

	if self._selectCareerCo and self._selectCareerCo.audioId ~= 0 then
		AudioMgr.instance:trigger(self._selectCareerCo.audioId)
	end

	Rouge2_Rpc.instance:sendEnterRouge2SelectCareerRequest(self._selectCareerId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		self:playAnim("close")
		Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
		Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitch, Rouge2_OutsideEnum.SceneIndex.LevelScene)
	end)
end

function Rouge2_CareerSelectView:onSceneSwitchFinish()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	self:closeThis()
	Rouge2_Controller.instance:enterRouge()
end

function Rouge2_CareerSelectView:_editableInitView()
	gohelper.setActive(self._goSkillItem, false)
	gohelper.setActive(self._goRelicsItem, false)

	self._goLeftArrow = self._btnLeftArrow.gameObject
	self._goRightArrow = self._btnRightArrow.gameObject
	self._goScrollSkill = self._scrollSkill.gameObject
	self._goScrollRelics = self._scrollRelics.gameObject

	local goCareerMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._goCareer)

	self._attributeMap = Rouge2_CareerAttributeMap.Get(goCareerMap, Rouge2_Enum.AttrMapUsage.CareerSelectView)

	self._attributeMap:setCareerSelectVisible(false)
	self._attributeMap:setBgVisible(false)

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_CareerSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EnterCareerView)
	Rouge2_CareerSelectListModel.instance:init()
end

function Rouge2_CareerSelectView:_onSelectCareer(careerId)
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)

	if not careerCo or self._selectCareerId == careerId then
		return
	end

	local firstSelect = not self._selectCareerCo and not self._selectCareerId

	self._selectCareerCo = careerCo
	self._selectCareerId = self._selectCareerCo.id

	if not firstSelect then
		Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchRefresh, self.onCareerSwitchRefresh, self)
		Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchFinish, self.onCareerSwitchFinish, self)
		Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.CareerSwitchRefresh, self.onCareerSwitchRefresh, self)
		Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.CareerSwitchFinish, self.onCareerSwitchFinish, self)
		self:playAnim("switch", true)
	else
		self:onCareerSwitchRefresh()
	end
end

function Rouge2_CareerSelectView:onCareerSwitchRefresh()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchRefresh, self.onCareerSwitchRefresh, self)

	self._txtDescr.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_careerselectview_careertips"), self._selectCareerCo.careerDesc)

	self._attributeMap:onUpdateMO(self._selectCareerId, Rouge2_Enum.AttributeData.Config)
	self:refreshBtn()
	self:refreshTag()
	self:refreshAttributeMap()
	self:refreshActiveSkillList()
	self:refreshInitialRelicsList()
end

function Rouge2_CareerSelectView:onCareerSwitchFinish()
	self:playAnim("idle", true)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchFinish, self.onCareerSwitchFinish, self)
end

function Rouge2_CareerSelectView:playAnim(animName, withAttributeMap)
	self.animator:Play(animName, 0, 0)

	if self._attributeMap and withAttributeMap then
		self._attributeMap:playAnim(animName)
	end
end

function Rouge2_CareerSelectView:refreshTag()
	local recommendTeamStr = Rouge2_CareerConfig.instance:getCareerRecommendTeamStr(self._selectCareerId)
	local hasRecommendTeam = not string.nilorempty(recommendTeamStr)

	gohelper.setActive(self._goRecommend, hasRecommendTeam)

	if not hasRecommendTeam then
		return
	end

	self._txtRecommend.text = recommendTeamStr
end

function Rouge2_CareerSelectView:refreshBtn()
	local canSwitchNext = Rouge2_CareerSelectListModel.instance:canSwitch(true)
	local canSwitchPre = Rouge2_CareerSelectListModel.instance:canSwitch(false)
	local goEnableLeft = gohelper.findChild(self._goLeftArrow, "enable")
	local goDisenableLeft = gohelper.findChild(self._goLeftArrow, "disable")
	local goEnableRight = gohelper.findChild(self._goRightArrow, "enable")
	local goDisenableRight = gohelper.findChild(self._goRightArrow, "disable")

	gohelper.setActive(goEnableLeft, canSwitchPre)
	gohelper.setActive(goDisenableLeft, not canSwitchPre)
	gohelper.setActive(goEnableRight, canSwitchNext)
	gohelper.setActive(goDisenableRight, not canSwitchNext)
end

function Rouge2_CareerSelectView:refreshAttributeMap()
	self._attributeMap:onUpdateMO(self._selectCareerId, Rouge2_Enum.AttributeData.Config)
end

function Rouge2_CareerSelectView:refreshActiveSkillList()
	if not self._selectCareerCo then
		return
	end

	local skillIds = Rouge2_CareerConfig.instance:getCareerActiveSkillIds(self._selectCareerId) or {}
	local skillNum = skillIds and #skillIds or 0

	gohelper.setActive(self._goScrollSkill, skillNum > 0)
	gohelper.CreateObjList(self, self._refreshActiveSkillItem, skillIds, self._goSkillList, self._goSkillItem, Rouge2_CareerActiveSkillItem)
end

function Rouge2_CareerSelectView:_refreshActiveSkillItem(skillItem, skillId, index)
	skillItem:onUpdateMO(self._selectCareerId, skillId)
end

function Rouge2_CareerSelectView:refreshInitialRelicsList()
	if not self._selectCareerCo then
		return
	end

	local relicsIdList = Rouge2_CareerConfig.instance:getCareerInitialColletions(self._selectCareerId) or {}
	local visibleRelicsIdList = {}

	for _, relicsId in ipairs(relicsIdList) do
		local relicsCo = Rouge2_BackpackHelper.getItemConfig(relicsId)

		if relicsCo and relicsCo.invisible ~= 1 then
			table.insert(visibleRelicsIdList, relicsId)
		end
	end

	local relicsNum = visibleRelicsIdList and #visibleRelicsIdList or 0

	gohelper.setActive(self._goScrollRelics, relicsNum > 0)
	gohelper.CreateObjList(self, self._refreshRelicsItem, visibleRelicsIdList, self._goRelicsList, self._goRelicsItem, Rouge2_CareerCollectionItem)
end

function Rouge2_CareerSelectView:_refreshRelicsItem(relicsItem, relicsId, index)
	relicsItem:onUpdateMO(relicsId)
end

function Rouge2_CareerSelectView:onClose()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchRefresh, self.onCareerSwitchRefresh, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.CareerSwitchFinish, self.onCareerSwitchFinish, self)
end

function Rouge2_CareerSelectView:onDestroyView()
	return
end

return Rouge2_CareerSelectView

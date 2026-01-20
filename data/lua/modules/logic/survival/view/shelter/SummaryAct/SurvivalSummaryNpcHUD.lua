-- chunkname: @modules/logic/survival/view/shelter/SummaryAct/SurvivalSummaryNpcHUD.lua

module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryNpcHUD", package.seeall)

local SurvivalSummaryNpcHUD = class("SurvivalSummaryNpcHUD", LuaCompBase)

function SurvivalSummaryNpcHUD:ctor(entityGO)
	self.entityGO = entityGO
end

function SurvivalSummaryNpcHUD:init(viewGO)
	self.viewGO = viewGO
	self._animroot = gohelper.findChildAnim(self.viewGO, "root")
	self._imagebubble = gohelper.findChildImage(self.viewGO, "root/#image_bubble")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._goInfo = gohelper.findChild(self.viewGO, "root/#go_Info")
	self._animgoinfo = self._goInfo:GetComponent(gohelper.Type_Animation)
	self._txtInfo = gohelper.findChildText(self.viewGO, "root/#go_Info/Info/#txt_Info")
	self._imagelevel = gohelper.findChildImage(self.viewGO, "root/#go_Info/Info/#txt_Info/#image_level")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_Info/Info/#txt_Info/#go_reddot")
	self._txtadd = gohelper.findChildText(self.viewGO, "root/#go_Info/Info/#txt_Info/#txt_add")
	self.txt_name = gohelper.findChildText(self.viewGO, "root/#go_Info/#txt_name")
	self.trans = viewGO.transform

	transformhelper.setLocalPos(self.trans, 9999, 9999, 0)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	gohelper.setActive(self._goarrow, false)

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.entityGO.transform, 0, 1.1, 0, 0, 0)
	self._uiFollower:SetEnable(true)
end

function SurvivalSummaryNpcHUD:addEventListeners()
	return
end

function SurvivalSummaryNpcHUD:removeEventListeners()
	return
end

function SurvivalSummaryNpcHUD:playCloseAnim()
	self._animroot:Play(UIAnimationName.Close)
end

function SurvivalSummaryNpcHUD:onDestroy()
	if self.textTweenId then
		ZProj.TweenHelper.KillById(self.textTweenId)

		self.textTweenId = nil
	end
end

function SurvivalSummaryNpcHUD:setData(npcId, upInfo)
	self.npcId = npcId
	self.upInfo = upInfo
	self.npcCfg = SurvivalConfig.instance:getNpcConfig(self.npcId)

	local renown = SurvivalConfig.instance:getNpcRenown(self.npcId)

	self.reputationId = renown[1]
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	local survivalShelterBuildingMo = self.weekInfo:getBuildingMoByReputationId(self.reputationId)

	self.reputationLevel = survivalShelterBuildingMo.survivalReputationPropMo.prop.reputationLevel
	self.reputationCfg = SurvivalConfig.instance:getReputationCfgById(self.reputationId, self.reputationLevel)

	local reputationType = self.reputationCfg.type
	local icon = SurvivalUnitIconHelper.instance:getRelationIcon(reputationType)

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageicon, icon)

	self.txt_name.text = self.npcCfg.name
	self._txtInfo.text = self.reputationCfg.name

	local path = string.format("survival_level_icon_%s", self.reputationLevel)

	UISpriteSetMgr.instance:setSurvivalSprite(self._imagelevel, path)

	local reputationValue = SurvivalConfig.instance:getNpcReputationValue(self.npcId)

	self.startValue = 0
	self.endValue = reputationValue
	self._txtadd.text = string.format("+%s", self.startValue)
	self.textTweenId = ZProj.TweenHelper.DOTweenFloat(self.startValue, self.endValue, 2, self.setPercentValue, self.onTweenFinish, self, nil, EaseType.OutQuart)

	if self.upInfo then
		self._animgoinfo:Play()
	end
end

function SurvivalSummaryNpcHUD:setPercentValue(value)
	local str = string.format("+%s", math.floor(value))

	self._txtadd.text = str
end

function SurvivalSummaryNpcHUD:onTweenFinish()
	self:setPercentValue(self.endValue)
end

return SurvivalSummaryNpcHUD

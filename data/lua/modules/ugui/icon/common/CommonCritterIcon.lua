-- chunkname: @modules/ugui/icon/common/CommonCritterIcon.lua

module("modules.ugui.icon.common.CommonCritterIcon", package.seeall)

local CommonCritterIcon = class("CommonCritterIcon", ListScrollCellExtend)

function CommonCritterIcon:onInitView()
	self._imagequality = gohelper.findChildImage(self.viewGO, "#simage_quality")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gomood = gohelper.findChild(self.viewGO, "#go_mood")
	self._gobuildingIcon = gohelper.findChild(self.viewGO, "#go_buildingIcon")
	self._imagebuildingIcon = gohelper.findChildImage(self.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._gomaturity = gohelper.findChild(self.viewGO, "#go_manufacture")
	self._goindex = gohelper.findChild(self.viewGO, "#go_index")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_index/#txt_index")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")
	self._gouptips = gohelper.findChild(self.viewGO, "#go_uptips")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_special")

	self:setSelectUIVisible()
	self:showIndex()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonCritterIcon:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CommonCritterIcon:removeEvents()
	self._btnclick:RemoveClickListener()
end

function CommonCritterIcon:_btnclickOnClick()
	if self.mo and self.mo.uid then
		SLFramework.SLLogger.Log("魔精uid:" .. self.mo.uid)
	end

	if self._customCallback then
		return self._customCallback(self._customCallbackObj, self._customClickParams)
	end
end

function CommonCritterIcon:_editableInitView()
	self.trans = self.viewGO.transform

	self:hideMood()
end

function CommonCritterIcon:getCritterMo(nilError)
	if not self.mo and nilError then
		logError(string.format("CommonCritterIcon:getCritterMo error, no critterMo, uid:%s", self.critterUid))
	end

	return self.mo
end

function CommonCritterIcon:onUpdateMO(mo)
	self.mo = mo
	self.critterUid = self.mo:getId()
	self.critterId = self.mo:getDefineId()

	self:refresh()
end

function CommonCritterIcon:setMOValue(critterUid, critterId)
	self.critterUid = critterUid
	self.critterId = critterId
	self.mo = CritterModel.instance:getCritterMOByUid(self.critterUid)

	if self.mo and not self.critterId then
		self.critterId = self.mo:getDefineId()
	end

	self:refresh()
end

function CommonCritterIcon:setSelectUIVisible(isVisible)
	self._isShowSelectedUI = isVisible

	self:onSelect()

	if self._isShowSelectedUI then
		CritterController.instance:dispatchEvent(CritterEvent.CheckCritterIconSelected, self.critterUid, self.critterId)
	end
end

function CommonCritterIcon:setIsShowBuildingIcon(isShow)
	self._isShowBuildingIcon = isShow

	self:refreshBuildingIcon()
end

function CommonCritterIcon:setCanClick(isCanClick)
	gohelper.setActive(self._btnclick.gameObject, isCanClick)
end

function CommonCritterIcon:setCustomClick(callback, callbackObj, params)
	self._customCallback = callback
	self._customCallbackObj = callbackObj
	self._customClickParams = params
end

function CommonCritterIcon:setLockIconShow(isShow)
	self._isShowLockIcon = isShow

	self:refreshLockIcon()
end

function CommonCritterIcon:setMaturityIconShow(isShow)
	self._isShowMaturityIcon = isShow

	self:refreshMaturityIcon()
end

function CommonCritterIcon:refresh()
	self:refreshIcon()
	self:refreshRare()
	self:refreshBuildingIcon()
	self:refreshLockIcon()
	self:refreshMaturityIcon()
end

function CommonCritterIcon:refreshIcon()
	local skinId
	local critterMo = self:getCritterMo()

	if critterMo then
		skinId = critterMo:getSkinId()
	else
		skinId = CritterConfig.instance:getCritterNormalSkin(self.critterId)
	end

	local iconName = CritterConfig.instance:getCritterHeadIcon(skinId)

	if not string.nilorempty(iconName) then
		local iconPath = ResUrl.getCritterHedaIcon(iconName)

		self:_loadIcon(iconPath)
	end
end

function CommonCritterIcon:_loadIcon(icon)
	if not icon then
		return
	end

	self._simageicon:LoadImage(icon)
end

function CommonCritterIcon:refreshRare()
	local rare = CritterConfig.instance:getCritterRare(self.critterId)

	if rare then
		UISpriteSetMgr.instance:setCritterSprite(self._imagequality, CritterEnum.QualityImageNameMap[rare])
	end
end

function CommonCritterIcon:showMood()
	if not self._moodItem then
		self._moodItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gomood, CritterMoodItem)
	end

	self._moodItem:setCritterUid(self.critterUid)
	gohelper.setActive(self._gomood, true)
end

function CommonCritterIcon:hideMood()
	gohelper.setActive(self._gomood, false)
end

function CommonCritterIcon:showUpTip(isShow)
	gohelper.setActive(self._gouptips, isShow)
end

function CommonCritterIcon:showSpeical()
	local critterMo = self:getCritterMo()
	local canShow = critterMo:isMutate()

	gohelper.setActive(self._gospecial, canShow)
end

function CommonCritterIcon:refreshBuildingIcon()
	gohelper.setActive(self._gobuildingIcon, false)

	if not self._isShowBuildingIcon then
		return
	end

	local buildingIcon
	local stayBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(self.critterUid)

	stayBuildingUid = stayBuildingUid or ManufactureModel.instance:getCritterRestingBuilding(self.critterUid)

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(stayBuildingUid)

	if buildingMO then
		buildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(buildingMO.buildingId)
	end

	if not buildingIcon then
		local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(self.critterUid)

		if workingPathMO then
			local workingPathBuildingId = workingPathMO.buildingId
			local skinId = workingPathMO.buildingSkinId
			local vehicleCfg = RoomTransportHelper.getVehicleCfgByBuildingId(workingPathBuildingId, skinId)

			buildingIcon = vehicleCfg and vehicleCfg.buildIcon
		end
	end

	if not buildingIcon then
		local isCultivating = self.mo:isCultivating()

		if isCultivating then
			buildingIcon = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CultivatingIcon)
		end
	end

	if buildingIcon then
		UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingIcon, buildingIcon)
		gohelper.setActive(self._gobuildingIcon, true)
	end
end

function CommonCritterIcon:refreshLockIcon()
	local isShow = false

	if self._isShowLockIcon and self.mo then
		isShow = self.mo:isLock()
	end

	gohelper.setActive(self._golocked, isShow)
end

function CommonCritterIcon:refreshMaturityIcon()
	local isShow = false

	if self._isShowMaturityIcon and self.mo then
		isShow = self.mo:isMaturity()
	end

	gohelper.setActive(self._gomaturity, isShow)
end

function CommonCritterIcon:onSelect(isSelect)
	gohelper.setActive(self._goselected, self._isShowSelectedUI and isSelect)
end

function CommonCritterIcon:showIndex(index)
	if index then
		self._txtindex.text = index
	end

	gohelper.setActive(self._goindex, index)
end

function CommonCritterIcon:onDestroyView()
	if self._simageicon then
		self._simageicon:UnLoadImage()

		self._simageicon = nil
	end
end

return CommonCritterIcon

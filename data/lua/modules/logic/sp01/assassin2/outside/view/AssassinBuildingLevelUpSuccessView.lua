-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingLevelUpSuccessView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpSuccessView", package.seeall)

local AssassinBuildingLevelUpSuccessView = class("AssassinBuildingLevelUpSuccessView", BaseView)

function AssassinBuildingLevelUpSuccessView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._simagebuildingicon = gohelper.findChildSingleImage(self.viewGO, "root/#simage_buildingicon")
	self._goprops = gohelper.findChild(self.viewGO, "root/#go_props")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#go_props/prop/#image_icon")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBuildingLevelUpSuccessView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function AssassinBuildingLevelUpSuccessView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AssassinBuildingLevelUpSuccessView:_btncloseOnClick()
	self:closeThis()
end

function AssassinBuildingLevelUpSuccessView:_editableInitView()
	return
end

function AssassinBuildingLevelUpSuccessView:onUpdateParam()
	return
end

function AssassinBuildingLevelUpSuccessView:onOpen()
	local buildingType = self.viewParam and self.viewParam.buildingType
	local buildingMo = AssassinOutsideModel.instance:getBuildingMo(buildingType)

	if not buildingMo then
		return
	end

	local lv = buildingMo:getLv()
	local config = buildingMo:getConfig()
	local tipStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassinbuildinglevelupsuccessview_tips"), lv, config.desc)

	self._txtdesc.text = tipStr

	self._simagebuildingicon:LoadImage(ResUrl.getSp01AssassinSingleBg("manor/" .. config.levelupPic))
	UISpriteSetMgr.instance:setSp01AssassinSprite(self._imageicon, config.itemIcon)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
end

function AssassinBuildingLevelUpSuccessView:onClose()
	self._simagebuildingicon:UnLoadImage()
end

function AssassinBuildingLevelUpSuccessView:onDestroyView()
	return
end

return AssassinBuildingLevelUpSuccessView

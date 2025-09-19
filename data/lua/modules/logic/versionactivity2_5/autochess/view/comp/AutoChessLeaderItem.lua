module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderItem", package.seeall)

local var_0_0 = class("AutoChessLeaderItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handleView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "#btn_Click")
	arg_2_0._goSelectFrame = gohelper.findChild(arg_2_1, "#go_SelectFrame")
	arg_2_0._goUnLock = gohelper.findChild(arg_2_1, "#go_UnLock")
	arg_2_0._uiMesh = gohelper.findChildUIMesh(arg_2_1, "#go_UnLock/Mesh")
	arg_2_0._simageRole = gohelper.findChildSingleImage(arg_2_1, "#go_UnLock/Mesh/role")
	arg_2_0._imageRole = gohelper.findChildImage(arg_2_1, "#go_UnLock/Mesh/role")
	arg_2_0._txtHp = gohelper.findChildText(arg_2_1, "#go_UnLock/hp/#txt_Hp")
	arg_2_0._btnCheck = gohelper.findChildButtonWithAudio(arg_2_1, "#go_UnLock/#btn_Check")
	arg_2_0._goSelect = gohelper.findChild(arg_2_1, "#go_Select")
	arg_2_0._goLock = gohelper.findChild(arg_2_1, "#go_Lock")
	arg_2_0._txtLock = gohelper.findChildText(arg_2_1, "#go_Lock/#txt_Lock")

	gohelper.setActive(arg_2_0._btnClick, arg_2_0.handleView)
	gohelper.setActive(arg_2_0._btnCheck, arg_2_0.handleView)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnClick, arg_3_0.onClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnCheck, arg_3_0.onCheck, arg_3_0)
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0.loader then
		arg_4_0.loader:dispose()

		arg_4_0.loader = nil
	end
end

function var_0_0.setData(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.id = arg_5_1
		arg_5_0.config = lua_auto_chess_master.configDict[arg_5_1]

		arg_5_0._simageRole:LoadImage(ResUrl.getAutoChessIcon(arg_5_0.config.image), arg_5_0.loadCallback, arg_5_0)
		arg_5_0:loadMesh()

		arg_5_0._txtHp.text = arg_5_0.config.hp

		gohelper.setActive(arg_5_0.go, true)
	else
		local var_5_0 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)

		if var_5_0 ~= 0 then
			local var_5_1 = AutoChessConfig.instance:getEpisodeCO(var_5_0).name
			local var_5_2 = luaLang("autochess_leaderitem_unlock")

			arg_5_0._txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_5_2, var_5_1)
		end

		gohelper.setActive(arg_5_0.go, var_5_0 ~= 0)
	end

	gohelper.setActive(arg_5_0._goUnLock, arg_5_1)
	gohelper.setActive(arg_5_0._goLock, not arg_5_1)
end

function var_0_0.refreshSelect(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goSelect, arg_6_1)
	gohelper.setActive(arg_6_0._goSelectFrame, arg_6_1)
end

function var_0_0.onClick(arg_7_0)
	if not arg_7_0.id then
		return
	end

	arg_7_0.handleView:onClickLeader(arg_7_0)
end

function var_0_0.onCheck(arg_8_0)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = arg_8_0.id
	})
end

function var_0_0.loadMesh(arg_9_0)
	arg_9_0.meshUrl = AutoChessHelper.getMeshUrl(arg_9_0.config.image)
	arg_9_0.loader = MultiAbLoader.New()

	arg_9_0.loader:addPath(arg_9_0.meshUrl)
	arg_9_0.loader:startLoad(arg_9_0.loadResFinish, arg_9_0)
end

function var_0_0.loadResFinish(arg_10_0)
	local var_10_0 = arg_10_0.loader:getAssetItem(arg_10_0.meshUrl):GetResource(arg_10_0.meshUrl)

	arg_10_0._uiMesh.mesh = var_10_0

	arg_10_0._uiMesh:SetVerticesDirty()
end

function var_0_0.loadCallback(arg_11_0)
	arg_11_0._imageRole:SetNativeSize()
end

return var_0_0

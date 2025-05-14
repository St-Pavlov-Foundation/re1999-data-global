module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeartView", package.seeall)

local var_0_0 = class("V1a6_CachotHeartView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootPath = arg_1_1 or ""

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._rootGo = gohelper.findChild(arg_2_0.viewGO, arg_2_0._rootPath)

	gohelper.setActive(arg_2_0._rootGo, true)

	arg_2_0._gotipsbg = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg")
	arg_2_0._txttitle = gohelper.findChildTextMesh(arg_2_0._rootGo, "#go_tipsbg/title")
	arg_2_0._gotipsitem = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/nowDes/#go_tipsitem")
	arg_2_0._btnheartclick = gohelper.findChildButtonWithAudio(arg_2_0._rootGo, "#btn_heartclick")
	arg_2_0._slider = gohelper.findChildSlider(arg_2_0._rootGo, "#slider_heart")
	arg_2_0._txtnum = gohelper.findChildTextMesh(arg_2_0._rootGo, "#slider_heart/Handle Slide Area/Handle/#txt_num")
	arg_2_0._imagelight = gohelper.findChildImage(arg_2_0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light")
	arg_2_0._golighteffectyellow = gohelper.findChild(arg_2_0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/yellow")
	arg_2_0._golighteffectorange = gohelper.findChild(arg_2_0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/orange")
	arg_2_0._golighteffectblue = gohelper.findChild(arg_2_0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/blue")
	arg_2_0._gonexttitle = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/nextTitle")
	arg_2_0._txtnextNum = gohelper.findChildTextMesh(arg_2_0._rootGo, "#go_tipsbg/nextTitle/nextNum")
	arg_2_0._gonextDes = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/nextDes")
	arg_2_0._gonextDesItem = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/nextDes/#go_tipsitem")
	arg_2_0._gopretitle = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/preTitle")
	arg_2_0._txtpreNum = gohelper.findChildTextMesh(arg_2_0._rootGo, "#go_tipsbg/preTitle/preNum")
	arg_2_0._gopreDes = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/preDes")
	arg_2_0._gopreDesItem = gohelper.findChild(arg_2_0._rootGo, "#go_tipsbg/preDes/#go_tipsitem")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnheartclick:AddClickListener(arg_3_0.showHideTips, arg_3_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0._refreshInfo, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateHeart, arg_3_0._refreshInfo, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnheartclick:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_4_0._onTouchScreen, arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_4_0._refreshInfo, arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateHeart, arg_4_0._refreshInfo, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._golighteffectyellow, false)
	gohelper.setActive(arg_5_0._golighteffectorange, false)
	gohelper.setActive(arg_5_0._golighteffectblue, false)
	arg_5_0:_refreshInfo(true)
end

function var_0_0._refreshInfo(arg_6_0, arg_6_1)
	arg_6_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_6_0._rogueInfo then
		return
	end

	local var_6_0 = arg_6_0._rogueInfo.heart
	local var_6_1 = V1a6_CachotConfig.instance:getHeartConfig(var_6_0)

	arg_6_0._txttitle.text = var_6_1.title

	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end

	if arg_6_1 or not arg_6_0._nowHeart then
		arg_6_0:_setValue(var_6_0, true)

		arg_6_0._nowHeart = var_6_0
	elseif arg_6_0._nowHeart ~= var_6_0 then
		arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_6_0._nowHeart, var_6_0, 0.5, arg_6_0._setValue, arg_6_0._onTweenHeartFinish, arg_6_0)
	end

	local var_6_2 = arg_6_0:_getDesData(var_6_1.desc)

	gohelper.CreateObjList(arg_6_0, arg_6_0.onDesItemCreate, var_6_2, arg_6_0._gotipsitem.transform.parent.gameObject, arg_6_0._gotipsitem)

	local var_6_3 = lua_rogue_heartbeat.configDict[var_6_1.id - 1]
	local var_6_4 = lua_rogue_heartbeat.configDict[var_6_1.id + 1]

	if var_6_3 then
		local var_6_5 = string.splitToNumber(var_6_3.range, "#")

		arg_6_0._txtpreNum.text = formatLuaLang("v1a6_cachot_heart_lt", var_6_5[2])

		gohelper.setActive(arg_6_0._gopretitle, true)
		gohelper.setActive(arg_6_0._gopreDes, true)

		local var_6_6 = arg_6_0:_getDesData(var_6_3.desc)

		gohelper.CreateObjList(arg_6_0, arg_6_0.onDesItemCreate, var_6_6, arg_6_0._gopreDesItem.transform.parent.gameObject, arg_6_0._gopreDesItem)
	else
		gohelper.setActive(arg_6_0._gopretitle, false)
		gohelper.setActive(arg_6_0._gopreDes, false)
	end

	if var_6_4 then
		local var_6_7 = string.splitToNumber(var_6_4.range, "#")

		arg_6_0._txtnextNum.text = formatLuaLang("v1a6_cachot_heart_gt", var_6_7[1])

		gohelper.setActive(arg_6_0._gonexttitle, true)
		gohelper.setActive(arg_6_0._gonextDes, true)

		local var_6_8 = arg_6_0:_getDesData(var_6_4.desc)

		gohelper.CreateObjList(arg_6_0, arg_6_0.onDesItemCreate, var_6_8, arg_6_0._gonextDesItem.transform.parent.gameObject, arg_6_0._gonextDesItem)
	else
		gohelper.setActive(arg_6_0._gonexttitle, false)
		gohelper.setActive(arg_6_0._gonextDes, false)
	end
end

function var_0_0._getDesData(arg_7_0, arg_7_1)
	local var_7_0 = {}

	if not string.nilorempty(arg_7_1) then
		var_7_0 = string.split(arg_7_1, "\n")
	end

	return var_7_0
end

function var_0_0._onTweenHeartFinish(arg_8_0)
	arg_8_0._tweenId = nil
end

function var_0_0._setValue(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1 = math.floor(arg_9_1)

	local var_9_0 = V1a6_CachotConfig.instance:getHeartConfig(arg_9_1)
	local var_9_1 = lua_rogue_const.configDict[V1a6_CachotEnum.Const.HeartConst].value
	local var_9_2 = string.splitToNumber(var_9_1, "#")

	arg_9_0._txtnum.text = arg_9_1

	arg_9_0._slider:SetValue((arg_9_1 - var_9_2[1]) / (var_9_2[2] - var_9_2[1]))

	local var_9_3
	local var_9_4

	if var_9_2[3] > var_9_0.id then
		var_9_3 = "v1a6_cachot_img_heartblue"
		var_9_4 = arg_9_0._golighteffectblue
	elseif var_9_2[3] == var_9_0.id then
		var_9_3 = "v1a6_cachot_img_heartyellow"
		var_9_4 = arg_9_0._golighteffectyellow
	elseif var_9_2[3] < var_9_0.id then
		var_9_3 = "v1a6_cachot_img_heartorange"
		var_9_4 = arg_9_0._golighteffectorange
	end

	if not arg_9_2 and arg_9_0._nowIcon ~= var_9_3 then
		gohelper.setActive(var_9_4, false)
		gohelper.setActive(var_9_4, true)
	end

	arg_9_0._nowIcon = var_9_3
	arg_9_0._nowHeart = arg_9_1

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_9_0._imagelight, var_9_3)
end

function var_0_0.onDesItemCreate(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.findChildTextMesh(arg_10_1, "desc").text = arg_10_2
end

function var_0_0._onTouchScreen(arg_11_0)
	if gohelper.isMouseOverGo(arg_11_0._btnheartclick) then
		return
	end

	gohelper.setActive(arg_11_0._gotipsbg, false)
end

function var_0_0.showHideTips(arg_12_0)
	local var_12_0 = not arg_12_0._gotipsbg.activeSelf

	gohelper.setActive(arg_12_0._gotipsbg, var_12_0)
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._tweenId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenId, false)

		arg_13_0._tweenId = nil
	end
end

return var_0_0

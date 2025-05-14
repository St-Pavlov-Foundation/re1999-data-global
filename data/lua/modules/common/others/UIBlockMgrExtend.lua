module("modules.common.others.UIBlockMgrExtend", package.seeall)

local var_0_0 = class("UIBlockMgrExtend", LuaCompBase)
local var_0_1 = "ui/viewres/common/blockanimui.prefab"
local var_0_2 = "UIRoot/TOP/UIEndBlock"
local var_0_3 = "effects/prefabs/weak_network"
local var_0_4 = "effects/prefabs/weak_network/weak_network_effect_loop.prefab"
local var_0_5 = "effects/prefabs/weak_network/weak_network_effect_end.prefab"
local var_0_6 = 2
local var_0_7 = 1.2
local var_0_8 = true

var_0_0.CircleMvDelay = nil

function var_0_0.setNeedCircleMv(arg_1_0)
	if var_0_8 ~= arg_1_0 then
		if canLogNormal then
			logNormal((arg_1_0 and "显示菊花" or "隐藏菊花") .. debug.traceback("", 2))
		end

		var_0_8 = arg_1_0
	end
end

function var_0_0.preload(arg_2_0, arg_2_1)
	var_0_0._callback = arg_2_0
	var_0_0._callbackObj = arg_2_1
	var_0_0._loader = PrefabInstantiate.Create(UIBlockMgr.instance:getBlockGO())

	var_0_0._loader:startLoad(var_0_1, var_0_0._onCallback)
end

function var_0_0._onCallback()
	if var_0_0._callback then
		var_0_0._callback(var_0_0._callbackObj)
	end

	var_0_0._callback = nil
	var_0_0._callbackObj = nil

	local var_3_0 = UIBlockMgr.instance:getBlockGO()
	local var_3_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, var_0_0)

	var_3_1:setGO(var_0_0._loader:getInstGO())

	var_0_0.instance = var_3_1
end

function var_0_0.getEndUIBlockGo()
	if not var_0_0._endUIBlockGo then
		var_0_0._endUIBlockGo = gohelper.find(var_0_2)
	end

	return var_0_0._endUIBlockGo
end

function var_0_0.setGO(arg_5_0, arg_5_1)
	arg_5_0._loopGoWrapper = arg_5_1
	arg_5_0._endGoWrapper = gohelper.clone(arg_5_0._loopGoWrapper, var_0_0.getEndUIBlockGo(), "endblockanimui")
	arg_5_0.isPlay = false

	if GameResMgr.IsFromEditorDir then
		loadAbAsset(var_0_4, false, arg_5_0._onLoopLoadCallback, arg_5_0)
		loadAbAsset(var_0_5, false, arg_5_0._onEndLoadCallback, arg_5_0)
	else
		loadAbAsset(var_0_3, false, arg_5_0._onAbLoadCallback, arg_5_0)
	end

	arg_5_0._txt = gohelper.findChildText(arg_5_1, "Text")
	arg_5_0._clickCounter = 0

	SLFramework.UGUI.UIClickListener.Get(arg_5_1.transform.parent.gameObject):AddClickListener(arg_5_0._onClickBlock, arg_5_0)
end

function var_0_0.setTips(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_0._txt) then
		return
	end

	if string.nilorempty(arg_6_1) then
		arg_6_0._txt.text = "CONNECTING"
	else
		arg_6_0._txt.text = arg_6_1
	end
end

function var_0_0._onClickBlock(arg_7_0)
	arg_7_0._clickCounter = arg_7_0._clickCounter + 1

	if arg_7_0._clickCounter == 30 then
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(UIBlockMgr.instance._blockKeyDict) do
			table.insert(var_7_0, iter_7_0)
		end

		local var_7_1 = ConnectAliveMgr.instance:getUnresponsiveMsgList()

		if #var_7_0 == 1 and var_7_0[1] == UIBlockKey.MsgLock then
			if #var_7_1 == 0 then
				UIBlockMgr.instance:endAll()
				logError("没有要等待的回包，关闭遮罩")

				return
			end

			if not isDebugBuild then
				return
			end
		end

		if isDebugBuild and tabletool.indexOf(var_7_0, UIBlockKey.MsgLock) then
			local var_7_2 = ""

			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				var_7_2 = string.format("%s%s,", var_7_2, iter_7_3.msg.__cname)
			end

			logError(string.format("Block Msg count=%d: %s", #var_7_1, var_7_2))
		end

		logError("BlockKeys: " .. table.concat(var_7_0, ","))
	end
end

function var_0_0._onLoopLoadCallback(arg_8_0, arg_8_1)
	if arg_8_1.IsLoadSuccess then
		arg_8_1:Retain()
		gohelper.clone(arg_8_1:GetResource(var_0_4), gohelper.findChild(arg_8_0._loopGoWrapper, "network_wrapper"))
	end
end

function var_0_0._onEndLoadCallback(arg_9_0, arg_9_1)
	if arg_9_1.IsLoadSuccess then
		arg_9_1:Retain()
		gohelper.clone(arg_9_1:GetResource(var_0_5), gohelper.findChild(arg_9_0._endGoWrapper, "network_wrapper"))
	end
end

function var_0_0._onAbLoadCallback(arg_10_0, arg_10_1)
	if arg_10_1.IsLoadSuccess then
		arg_10_1:Retain()
		gohelper.clone(arg_10_1:GetResource(var_0_4), gohelper.findChild(arg_10_0._loopGoWrapper, "network_wrapper"))
		gohelper.clone(arg_10_1:GetResource(var_0_5), gohelper.findChild(arg_10_0._endGoWrapper, "network_wrapper"))
	end
end

function var_0_0.onEnable(arg_11_0)
	arg_11_0._clickCounter = 0

	TaskDispatcher.cancelTask(arg_11_0._onEndAnimationFinished, arg_11_0)
	gohelper.setActive(var_0_0.getEndUIBlockGo(), false)
	gohelper.setActive(arg_11_0._loopGoWrapper, false)

	if var_0_8 then
		local var_11_0 = var_0_0.CircleMvDelay and var_0_0.CircleMvDelay > 0 and var_0_0.CircleMvDelay or var_0_6

		TaskDispatcher.runDelay(arg_11_0._onDelayShow, arg_11_0, var_11_0)
	end
end

function var_0_0.onDisable(arg_12_0)
	arg_12_0._clickCounter = 0

	TaskDispatcher.cancelTask(arg_12_0._onDelayShow, arg_12_0)
	gohelper.setActive(arg_12_0._loopGoWrapper, false)

	if not arg_12_0.isPlay then
		return
	end

	if var_0_8 then
		gohelper.setActive(var_0_0.getEndUIBlockGo(), true)
		TaskDispatcher.runDelay(arg_12_0._onEndAnimationFinished, arg_12_0, var_0_7)
	end
end

function var_0_0._onDelayShow(arg_13_0)
	if not var_0_8 then
		return
	end

	gohelper.setActive(arg_13_0._loopGoWrapper, true)

	arg_13_0.isPlay = true

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(UIBlockMgr.instance._blockKeyDict) do
		table.insert(var_13_0, iter_13_0)
	end

	logNormal("BlockKeys: " .. table.concat(var_13_0, ","))
end

function var_0_0._onEndAnimationFinished(arg_14_0)
	arg_14_0.isPlay = false

	TaskDispatcher.cancelTask(arg_14_0._onEndAnimationFinished, arg_14_0)
	gohelper.setActive(var_0_0.getEndUIBlockGo(), false)
end

return var_0_0

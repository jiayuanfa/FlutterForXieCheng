package com.example.asr.plugin.asr;

import android.util.Log;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;

/**
 * MethodChannel 结果回调
 * 给Dart通信
 */
public class ResultStateful implements MethodChannel.Result {
    private final static String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private boolean called;

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void success(@Nullable Object o) {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(String s, @Nullable String s1, @Nullable Object o) {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.error(s, s1, o);
    }

    @Override
    public void notImplemented() {
        if (called) {
            printError();
            return;
        }
        called = true;
        result.notImplemented();

    }

    private void printError() {
        Log.e(TAG, "error:result called");
    }
}

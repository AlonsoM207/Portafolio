//
//  LiveCameraController.swift
//  Proyecto_Equipo1
//
//  Created by Alumno on 09/10/23.
//
/*
import UIKit
import os
import AVFoundation
import Vision
import SwiftUI

typealias LivePredictionResults2 = [String: (basicValue: Double, displayValue: String)]

struct ValuePerCategory2 {
    var category: String
    var value: Double
}

final class LiveCameraViewController2: UIViewController {
    private var model: VNCoreMLModel?
    //private var model2: VNCoreMLModel?
    private let visionResultsDisplayLayer = CALayer()
    // handleObservations returns back the Vision classification results - [ValuesPerCategory] and [String] (the sorted label names) are used for generating the barchart from the results
    private var handleObservations: (LivePredictionResults2, String, String) -> ()
    
    private(set) var rawVideoDimensions: CGSize = .zero
    private var visionCoreMLRequests: [VNCoreMLRequest] = []
    private let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let videoOutputQueue = DispatchQueue(
        label: "VideoOutput",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem
    )
    
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var liveVideoFeedDisplayLayer = CALayer()
    
    init(handleObservations: @escaping (LivePredictionResults2, String, String) -> ()) {
        self.handleObservations = handleObservations
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liveVideoFeedDisplayLayer = view.layer
        setUpLiveCapture()
    }
    
    /// Builds vision requests using the provided URL and starts the session
    ///
    /// - Parameter url: Model URL
    func runSession() throws {
        self.model = try? VNCoreMLModel(for: PredictionStatus2().modelObject.model)
        //self.model2 = try? VNCoreMLModel(for: PredictionStatus().modelObject2.model)
        session.startRunning()
    }
    
    // MARK:- Live Capture
    private func setUpLiveCapture() {
        let videoDevice = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video, position: .back
        ).devices.first
        guard let videoDevice = videoDevice else { return }
        
        var deviceInput: AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch {
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.photo
        
        guard session.canAddInput(deviceInput) else {
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        
        guard session.canAddOutput(videoOutput) else {
            session.commitConfiguration()
            return
        }
        session.addOutput(videoOutput)
        
        let pixelBufferFormatKey = Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: pixelBufferFormatKey
        ]
        videoOutput.setSampleBufferDelegate(self, queue: videoOutputQueue)
        videoOutput.connection(with: .video)?.isEnabled = true // Always process the frames
        
        do {
            try videoDevice.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions(
                videoDevice.activeFormat.formatDescription
            )
            rawVideoDimensions.width = CGFloat(dimensions.width)
            rawVideoDimensions.height = CGFloat(dimensions.height)
            videoDevice.unlockForConfiguration()
        } catch {
        }
        
        session.commitConfiguration()
        
        // these were updated to correlate to PhotoCameraViewController setupPreviewLayers() - maybe they should be consolidated to one place
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.contentsGravity = .resizeAspect
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.connection?.videoOrientation = videoOrientationFromCurrentDeviceOrientation()
        let scaleFactor = 0.9
        let dimension = min (liveVideoFeedDisplayLayer.frame.size.width * scaleFactor, liveVideoFeedDisplayLayer.frame.size.height * scaleFactor)
        previewLayer?.frame = CGRect(x: 0, y:0, width: dimension + 41, height: dimension + 50)
        
        guard let previewLayer = previewLayer else { return }
        liveVideoFeedDisplayLayer.insertSublayer(previewLayer, at: 0)
    }
}

extension LiveCameraViewController2: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // adapted from https://www.letsbuildthatapp.com/course_video?id=1252
    
    func captureOutput2(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        
        guard
            let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
            let model = model
            else {
                return
            }
            //let model2 = model2
        
        // process image and resize to scale with training image dimensions
        let cvImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        let ciimage = CIImage(cvImageBuffer: cvImageBuffer)
        let context = CIContext()
        let cgImage = context.createCGImage(ciimage, from: ciimage.extent)
        let uiImage = UIImage(cgImage: cgImage!)
        let uiImageResized = uiImage.scaleAndCropImage(uiImage, toSize: CGSize(width: Constants.imgDim, height: Constants.imgDim))
        let newCiImage = CIImage(image: uiImageResized)
    
        let request = VNCoreMLRequest(model: model){ request, error in
            let observations = request.results as? [VNClassificationObservation] ?? []
            
            let predictionResultsMap = observations.map {
                (
                    $0.identifier,
                    (basicValue: Double($0.confidence), displayValue: String(format: "%.0f%%", $0.confidence * 100))
                )
            }
        
                    
            let topResult = observations.first
            let compiledResults = Dictionary(uniqueKeysWithValues: predictionResultsMap)
            
            DispatchQueue.main.async {
                self.handleObservations(compiledResults, topResult!.identifier, String(format: "%.0f%%", topResult!.confidence * 100))
            }
        } // request
        /*
        let request2 = VNCoreMLRequest(model: model2) { request2, error in
            let observations = request2.results as? [VNClassificationObservation] ?? []
            
            let predictionResultsMap = observations.map {
                (
                    $0.identifier,
                    (basicValue: Double($0.confidence), displayValue: String(format: "%.0f%%", $0.confidence * 100))
                )
            }
        
                    
            let topResult = observations.first
            let compiledResults = Dictionary(uniqueKeysWithValues: predictionResultsMap)
            
            DispatchQueue.main.async {
                self.handleObservations(compiledResults, topResult!.identifier, String(format: "%.0f%%", topResult!.confidence * 100))
            }
        } // request
        */
        request.imageCropAndScaleOption = .centerCrop
        //request2.imageCropAndScaleOption = .centerCrop
        
        try? VNImageRequestHandler(
            ciImage: newCiImage!,
            orientation: exifOrientation(),
            options: [:]
        ).perform([request])
        /*
        try? VNImageRequestHandler(
            ciImage: newCiImage!,
            orientation: exifOrientation(),
            options: [:]
        ).perform([request2])
         */
    }
}
*/

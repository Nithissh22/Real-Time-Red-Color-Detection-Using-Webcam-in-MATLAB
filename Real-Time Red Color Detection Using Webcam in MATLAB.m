cam = webcam;

.

figure; % Open a new figure for displaying output

while true
    img = snapshot(cam); % Capture a frame from the webcam
    
    % Convert to HSV for color detection
    hsvImg = rgb2hsv(img);
    hChannel = hsvImg(:,:,1); % Hue
    sChannel = hsvImg(:,:,2); % Saturation
    vChannel = hsvImg(:,:,3); % Value

    % Detect red color (two ranges)
    lowerRed1 = (hChannel >= 0) & (hChannel <= 0.1) & (sChannel > 0.4) & (vChannel > 0.4);
    lowerRed2 = (hChannel >= 0.9) & (hChannel <= 1) & (sChannel > 0.4) & (vChannel > 0.4);
    redMask = lowerRed1 | lowerRed2; % Combine both red masks

    % Find contours of red areas
    redDetected = any(redMask(:)); % True if any red is detected

    % Display the original image
    imshow(img);
    hold on;

    % Overlay text based on detection
    if redDetected
        text(50, 50, 'STOP: Red Detected!', 'Color', 'red', 'FontSize', 20, 'FontWeight', 'bold');
    else
        text(50, 50, 'Car Moving...', 'Color', 'green', 'FontSize', 20, 'FontWeight', 'bold');
    end
    
    hold off;
    drawnow; % Update the figure
end

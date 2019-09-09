$command = $_POST['command'];
$text = $_POST['text'];
$token = $_POST['token'];

if($token != 'erzduTBTiZlb2K8e8lL0jucs'){
    $msg = "The token for the slash command doesn't match. Check your script.";
    die($msg);
    echo $msg;
    
    $user_agent = "IsitupForSlack/1.0 (https://github.com/mccreath/istiupforslack; mccreath@gmail.com)";
    
    $url_to_check = "https://isitup.org/".$text.".json";
    
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
    curl_setopt($ch, CURLOPT_USERAGENT, $user_agent);
    
    $ch_response = curl_exec($ch);
    
    curl_close($ch);
    
    $response_array = json_decode($ch_response,true);
    
    if($ch_response === FALSE){
        
        $reply = "Isitup is not working.";
    }else{
        if($response_array["status_code"] == 1){
            
            $reply = ":thumbsup: I am happy to report that *<http://".$response_array["domain"]."|".$response_array["domain"].">* is *up*!";
        } else if($response_array["status_code"] == 2){
            
            $reply = ":disappointed: I am sorry to report that *<http://".$response_array["domain"]."|".$response_array["domain"].">* is *not up*!";
        } else if($response_array["status_code"] == 3){
            
            $reply = ":interrobang: *".$text."* does not appear to be a valid domain. \n";
            $reply .= "Please enter both the domain name AND suffix (example: *amazon.com* or *whitehouse.gov*).";
        }
    }
    
    echo $reply;


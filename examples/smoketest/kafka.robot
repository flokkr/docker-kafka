

*** Settings ***
Documentation    Test suite to check Kafka functionality
Library          OperatingSystem
Library          String
Resource         common.robot

*** Keywords
Execute
    [arguments]                     ${command}
    ${rc}                           ${output} =                 Run And Return Rc And Output           ${command}
    Log                             ${output}
    Should Be Equal As Integers     ${rc}                       0
    [return]                        ${output}


*** Test Cases ***

Send and receive kafka message
  ${random} =   Generate Random String  5  [NUMBERS]
                Execute        echo "test1" | /opt/kafka/bin/kafka-console-producer.sh --broker-list kafka-broker-0:9092 --topic ${random}
                Execute        echo "test2" | /opt/kafka/bin/kafka-console-producer.sh --broker-list kafka-broker-0:9092 --topic ${random}
  ${output} =   Execute        /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka-broker-0:9092 --topic ${random} --from-beginning --max-messages 2
  Should contain  ${output}    test1
  Should contain  ${output}    test2

